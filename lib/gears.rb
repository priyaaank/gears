class Gear

  attr_accessor :processors,

  def initialize(&blk)
    @config = {}
    @processors = []
    instance_eval(&blk)
  end

  def method_missing(method_name, *args)
    @config[method_name] = args.first
  end

  def processor(&blk)
    @processors << Processor.evaluate(&blk)
  end

  def self.declare(&blk)
    Gear.new(&blk)
  end

  def test_me
    
  end

end
