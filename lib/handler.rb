class Handler

  attr_accessor :config, :name, :workers

  def initialize(name, number = (DEFAULT_WORKER_COUNT || 4))
    @config = {}
    @name = name
    @workder = number
  end

  def self.evaluate(name, &blk)
    Handler.new.instance_eval(&blk)
  end

  def method_missing(name, *args)
    @config[name] = args.first
  end

end
