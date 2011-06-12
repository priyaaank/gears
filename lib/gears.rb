class Gear

  attr_accessor :config, :name, :queue_name 

  def initialize(name)
    @name = name
    @config = {}
  end

  def method_missing(method_name, *args)
    @config[method_name] = args.first
  end

  def handler(&blk)
    Handler.evaluate(&blk)
  end

  def start
    @klass ||= begin
      require "#{DAEMON_ROOT}/lib/generators/#{@name.to_s}"
      Object.const_get(camelize(@name)).new
    end
    @klass
  end

  def self.gear(&blk)
    Gear.new.instance_evak(&blk)
  end

  def self.declare(&blk)
    Gear.class_eval(&blk)
  end

  def camelize(name)
    name.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
  end

end
