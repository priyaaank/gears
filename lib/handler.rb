class Handler

  attr_accessor :config, :name
  attr_reader :handler_klass

  def initialize(name, &blk)
    @config = {}
    @name = name
    instance_eval(&blk)
    prepare_instance
  end

  def method_missing(name, *args)
    @config[name] = args.first
  end

  private

  def camelize(name)
    name.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
  end
  
  def prepare_instance
    @handler_klass ||= begin
      require "#{DAEMON_ROOT}/lib/handlers/#{@name.to_s}"
      Object.const_get(camelize(@name))
    end
  end

end
