# Copyright (C) 2012 Kenichi Kamiya

# @example
#   require 'abstractstack/subscriptable'
#   
#   class LIFO < AbstractStack
#     include Subscriptable
#
#     def at(pos)
#       super pos, :top
#     end
#   end
module AbstractStack::Subscriptable
  
  # @param [#to_int] pos
  # @param [Symbol] start - select one from :bottom or :top(:peek)
  # @abstract - Define start point of index
  def at(pos, start)
    raise InvalidStackOperation if empty?

    @list[_index_for pos, start]
  end
  
  # @param [#to_int] pos
  def [](pos)
    at pos
  end

  private
  
  def _validate_subscript(pos)
    if pos < 0
      if pos.abs > length
        raise IndexError
      end
    else
      if (pos + 1) > length
        raise IndexError
      end
    end
  end
  
  # when "start" is :top(:peek)
  # 0 <-> -1, 1 <-> -2, 5 <-> -6
  def _index_for(pos, start)
    pos = pos.to_int
    _validate_subscript pos
    
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
