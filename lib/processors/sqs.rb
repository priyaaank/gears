class Sqs

  def process(queue_name, &blk)
    puts "*"*100
    puts "Processing done on queue: #{queue_name}"
    puts "*"*100
    blk.call "Some new Shit has come up!"
  end
end
