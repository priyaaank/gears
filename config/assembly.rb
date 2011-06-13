require 'gear'

Gear.declare do

    processor :sqs do
      queue         :thumbnail_queue
      workers       5

      handler       :thumbnailer do
        some_random_value 'whatever'
      end

      handler       :thumbnailer do
        some_random_value 'seriously'
      end

      AMAZON_KEY    APP_CONFIG['keys']['amazon_key']
      AMAZON_SECRET APP_CONFIG['keys']['amazon_secret']
    end

end
