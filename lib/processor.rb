require 'handler'

class Processor

  attr_accessor :queue_name, :config, :name, :handlers, :worker_count
  attr_reader :processor_klass

  def initialize(name, &blk)
    @config = {}
    @handlers = []
    @name = name
    worker_count = 4 
    instance_eval(&blk)
    prepare_instance
  end

  def queue(name)
    @queue_name = name
  end

  def workers(count)
    @worker_count = count
  end

  def handler(name, &blk)
    @handlers << Handler.new(name, &blk)
  end

  def method_missing(method_name, *args)
    @config[method_name] = args.first
  end

  def run
    p = @processor_klass.new(@config, @queue_name)
    p.process(@queue_name) do |response|
      @handlers.each do |h|
        i = h.new_handler_instance
        i.process(response)
      end
    end
  end

  private

  def camelize(name)
    name.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
  end

  def prepare_instance
    @processor_klass ||= begin
      puts "processors/#{@name.to_s}"
      require "processors/#{@name.to_s}"
      Object.const_get(camelize(@name))
    end
  end

end
