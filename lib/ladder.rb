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
  begin
    require 'byebug'
  rescue LoadError => e  
     fail "Please install byebug via `gem install byebug` or add `byebug` to the Gemfile/gems.rb file. Error: #{e}"
  end
  def ladder(arg = nil, &block)
      
    if arg.is_a?(Hash) && arg[:stop]
      @saved_blocks.each.with_index do |block, i|
        # byebug
        @saved_blocks.delete_at(i) if arg[:stop] == block
      end
    else
      if !arg.nil?
      
      
        #- 1
      
      
        @saved_blocks.each { |block| block.call(arg) } 
      
      
      elsif block_given?
      
      
        #- 2
      
      
        @saved_blocks ||= []
        @saved_blocks.push(block)
        
        
        return block
      end
    end
  end
end

class Object
  include Ladder::FOR_RUBY_OBJECT
end

extend Ladder::FOR_RUBY_MAIN_OBJECT

 ladder
