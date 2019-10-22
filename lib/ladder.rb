RUBY_MAIN_OBJECT = self


class Ladder
  module FOR_RUBY_MAIN_OBJECT
    attr_accessor :singleton_ladder_instance
    def ladder(arg = nil, &block)
      self.singleton_ladder_instance ||= Ladder.new
      
      self.singleton_ladder_instance.ladder(arg, &block)
    end
  end
  
  module FOR_RUBY_OBJECT
    def ladder(arg = nil, &block)
      RUBY_MAIN_OBJECT.singleton_ladder_instance.ladder(arg, &block)
    end
    

  end
  
  def ladder(arg = nil, &block)
      
    if !arg.nil?
      
      
      #- 1
      
      
      @saved_blocks.each { |block| block.call(arg) } 
      
      
    elsif block_given?
      
      
      #- 2
      
      
      @saved_blocks ||= []
      @saved_blocks.push(block)
    end
  end
end

class Object
  include Ladder::FOR_RUBY_OBJECT
end

extend Ladder::FOR_RUBY_MAIN_OBJECT

 ladder
