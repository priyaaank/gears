require 'gear'

Gear.declare do

    processor :sqs do
      queue         :echo_queue
      workers       5

      handler       :thumbnailer do
        some_random_value 'whatever'
      end

      AMAZON_KEY    APP_CONFIG['keys']['amazon_key']
      AMAZON_SECRET APP_CONFIG['keys']['amazon_secret']
    end

end
