class AbstractStack

  class LIFO < self

    include Enumerable
    include Subscriptable
    
    alias_method :each, :lifo_each
    alias_method :reverse_each, :fifo_each
  
    # @param [Integer, #to_int] pos
    def at(pos)
      super pos, :top
    end

  end

  FILO = LIFO

end
