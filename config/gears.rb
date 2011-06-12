Gears.declare do

  gear :sqs do

    processor do
      queue_name    :thumbnail_queue
      AMAZON_KEY    ''
      AMAZON_SECRET ''
    end
    
    handler :thumbnailer do
      workers 5
    end

  end

end
