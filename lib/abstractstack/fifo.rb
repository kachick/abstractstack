class AbstractStack

  class FIFO < self

    include Enumerable
    include Subscriptable
    
    alias_method :each, :fifo_each
    alias_method :reverse_each, :filo_each

    # @param [Integer, #to_int] pos
    def at(pos)
      super pos, :bottom
    end

  end

  LILO = FIFO

end
