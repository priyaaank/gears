require 'sqs_async'

class Sqs

  include SQS

  attr_reader :aws_key, :aws_secret, :queue_name

  def initialize(config, queue_name)
    puts config.inspect
    @aws_key = config[:AMAZON_KEY]
    @aws_secret = config[:AMAZON_SECRET]
    @queue_name = queue_name
  end

  def process(queue_name, &blk)
    fetch_queue.call(queue_name)
  end

  private

  def fetch_queue
    got_queue = Proc.new do |queue|
      puts "Woohooo, we atleast got the queue"
      puts queue.inspect
      fetch_message.call(queue)
    end

    did_not_get_queue = Proc.new do |error|
      puts "We didn't even get the queue"
      puts error.inspect
    end

    Proc.new do |queue_name|
      create_queue(:queue_name => queue_name, :callbacks => {:success => got_queue, :failure => did_not_get_queue})
    end
  end

  def fetch_message
    receieved = Proc.new do |message|
      puts "We recieved shit"
      puts message.inspect
    end

    did_not_receive = Proc.new do |error|
      puts "Fuck this shitt!"
      puts error.inspect
    end

    Proc.new do |queue|
      receive_message(:queue => queue.first, :callbacks => {:success => receieved, :failure => did_not_receive})
    end
  end
end
