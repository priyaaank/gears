class Processor

  attr_accessor :queue_name, :config, :name, :handlers, :workers
  attr_reader :processor_klass

  def initialize(name, &blk)
    @config = {}
    @handlers = []
    workers = DEFAULT_WORKER_COUNT || 4
    instance_eval(&blk)
    prepare_instance
  end

  def handler(name, &blk)
    @handlers << Handler.new(name, &blk)
  end

  def method_missing(method_name, *args)
    @config[method_name] = args.first
  end

  def run
    @processor_klass.new(@config, @handler.new_handler_instance)
  end

  private

  def camelize(name)
    name.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
  end

  def prepare_instance
    @processor_klass ||= begin
      require "#{DAEMON_ROOT}/lib/processors/#{@name.to_s}"
      Object.const_get(camelize(@name))
    end
  end

end
