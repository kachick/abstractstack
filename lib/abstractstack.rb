# Copyright (C) 2012 Kenichi Kamiya

require 'forwardable'

# @abstract - Define start point of index and/or loop operations
# @example
#   class LIFO < AbstractStack
#     include Enumerable
#
#     alias_method :each, :lifo_each
#     alias_method :reverse_each, :fifo_each
#     alias_method :first, :top
#     alias_method :last, :bottom
#
#     def at(pos)
#       super pos, :top
#     end
#   end
class AbstractStack
  extend Forwardable

  VERSION = '0.0.2'.freeze

  class InvalidStackOperation < StandardError; end
  class UnderFlow < InvalidStackOperation; end
  class OverFlow < InvalidStackOperation; end
  
  attr_reader :limit
 
  def initialize(limit=nil)
    @list = []

    case limit
    when nil, 0, false
      @limit = nil
    when ->v{v.integer? && (v >= 1)}
      @limit = limit.to_int
    else
      raise TypeError
    end
  end

  def_delegators :@list, :length, :size, :empty?
  def_delegator  :@list, :first, :bottom
  def_delegator  :@list, :last, :top
  def_delegator  :@list, :last, :peek

  # @param [Object] value
  # @return [Object] value
  def push(value)
    if limit && (limit <= length)
      raise OverFlow
    else
      @list.push value
      self
    end
  end

  alias_method :<<, :push

  # @return [Object]
  def pop
    if empty?
      raise UnderFlow
    else
      @list.pop
    end
  end

  # @return [self]
  def fifo_each
    return to_enum(__callee__) unless block_given?

    @list.each{|v|yield v}
    self
  end
  
  alias_method :lilo_each, :fifo_each

  # @return [self]
  def filo_each
    return to_enum(__callee__) unless block_given?

    @list.reverse_each{|v|yield v}
    self
  end

  alias_method :lifo_each, :filo_each
  
  # @param [#to_int] pos
  # @param [Symbol] start
  # @abstract - Define start point of index
  def at(pos, start)
    raise InvalidStackOperation if empty?
    
    pos = pos.to_int
    
    if pos < 0
      if pos.abs > length
        raise IndexError
      end
    else
      if (pos + 1) > length
        raise IndexError
      end
    end
    
    case start
    when :bottom
      @list[pos]
    when :top, :peek
      @list.reverse[pos]
    else
      raise ArgumentError
    end
  end
  
  # @param [#to_int] pos
  def [](pos)
    at pos
  end

  # @return [Array]
  def to_a
    @list.dup
  end

  # @return [self]
  def freeze
    @list.freeze
    super
  end
  
  # @return [String]
  def inspect
    "#<#{self.class} limit=#{@limit.inspect} #{@list.inspect}>"
  end
  
  # @return [Boolean]
  def ==(other)
    (self.class == other.class) && @list == other._list
  end
  
  def eql?(other)
    (self.class == other.class) && 
      [limit, @list].eql?([other.limit, other._list])
  end

  # @return [Integer]
  def hash
    [@limit, @list].hash
  end
  
  protected
  
  def _list
    @list
  end

  private

  def initialize_copy(original)
    @list = @list.dup
  end

end
