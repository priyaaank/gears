class Handler

  attr_accessor :config, :name, :workers
  attr_reader :klass

  def initialize(name, number = (DEFAULT_WORKER_COUNT || 4))
    @config = {}
    @name = name
    @worker = number
  end

  def self.evaluate(name, &blk)
    Handler.new.instance_eval(&blk)
  end

  def method_missing(name, *args)
    @config[name] = args.first
  end

  def camelize(name)
    name.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
  end

  def prepare_instance
    @klass ||= begin
      require "#{DAEMON_ROOT}/lib/handlers/#{@name.to_s}"
      Object.const_get(camelize(@name)).new
    end
    @klass
  end

end
