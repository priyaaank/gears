require 'processor'

class Gear

  def self.method_missing(method_name, *args)
    @config[method_name] = args.first
  end

  def self.processor(name, &blk)
    @processors ||= []
    @processors << Processor.new(name, &blk)
  end

  def self.declare(&blk)
    class_eval(&blk)
  end

  def self.test_me
    @processors.each do |processor|
      puts "#"*100
      puts "Processing for processer: #{processor.name}"
      puts "#"*100

      processor.run
    end
  end

end
