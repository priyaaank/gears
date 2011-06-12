class Gear

  attr_accessor :processor, :workers, :name

  def initialize(name)
    @config = {}
    @name = name
  end

  def method_missing(method_name, *args)
    @config[method_name] = args.first
  end

  def handler(&blk)
    Handler.evaluate(&blk)
  end

  def processor(&blk)
    Processor.evaluate(&blk)
  end

  def self.gear(&blk)
    Gear.new.instance_eval(&blk)
  end

  def self.declare(&blk)
    Gear.class_eval(&blk)
  end

end
