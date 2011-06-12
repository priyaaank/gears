class Handler

  attr_accessor :config, :name
  attr_reader :handler_klass

  def initialize(name, &blk)
    @config = {}
    @name = name
    instance_eval(&blk) unless blk.nil?
    prepare_instance
  end

  def method_missing(name, *args)
    @config[name] = args.first
  end

  def new_handler_instance
    @handler_klass.new(@config)
  end

  private

  def camelize(name)
    name.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
  end
  
  def prepare_instance
    @handler_klass ||= begin
      require "handlers/#{@name.to_s}"
      Object.const_get(camelize(@name))
    end
  end

end
