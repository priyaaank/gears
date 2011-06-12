class Processor

  attr_accessor :queue_name, :name, :config
  attr_reader :klass

  def initialize(name)
    @config = {}
    @name = name
  end

  def self.evaluate(&blk)
    Processor.new.instance_eval(&blk)
  end

  def method_missing(method_name, *args)
    @config[method_name] = args.first
  end

  def camelize(name)
    name.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
  end

  def prepare_instance
    @klass ||= begin
      require "#{DAEMON_ROOT}/lib/processors/#{@name.to_s}"
      Object.const_get(camelize(@name)).new
    end
    @klass
  end

end
