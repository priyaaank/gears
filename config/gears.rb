Gears.declare do

    processor :sqs do
      queue_name    :thumbnail_queue
      workers       5
      handler       :thumbnailer

      AMAZON_KEY    ''
      AMAZON_SECRET ''
    end

end
