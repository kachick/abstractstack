# coding: us-ascii

class AbstractStack

  # @example  
  #   class LIFO < AbstractStack
  #     include Subscriptable
  #
  #     def at(pos)
  #       super pos, :top
  #     end
  #   end
  module Subscriptable
  
    # @param [Integer, #to_int] pos
    # @param [Symbol, #to_sym] start - select one from :bottom or :top(:peek)
    # @abstract - Define start point of index
    def at(pos, start)
      raise InvalidStackOperation if empty?

      @list.fetch _index_for(pos.to_int, start.to_sym)
    end
    
    # @param [Integer, #to_int] pos
    def [](pos)
      at pos
    end

    private

    def _index_for(pos, start)      
      case start
      when :bottom
        pos
      when :top, :peek
        (- pos) - 1
      else
        raise ArgumentError
      end
    end

  end

end