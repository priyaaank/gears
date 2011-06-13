class Sqs

  attr_reader :amazon_key, :amazon_secret, :queue_name

  def initialize(config, queue_name)
    @amazon_key = config[:AMAZON_KEY]
    @amazon_secret = config[:AMAZON_SECRET]
    @queue_name = queue_name
  end

  def process(queue_name, &blk)
    puts "*"*100
    puts "Processing done on queue: #{queue_name}"
    puts "*"*100
    blk.call "Some new Shit has come up!"
  end
end
