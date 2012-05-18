# Copyright (C) 2012 Kenichi Kamiya

require 'forwardable'
require_relative 'abstractstack/version'
require_relative 'abstractstack/exceptions'

# @abstract
# @example
#   class SimpleStack < AbstractStack; end
# @example
#   class LIFO < AbstractStack
#     include Enumerable
#
#     alias_method :each, :lifo_each
#     alias_method :reverse_each, :fifo_each
#     alias_method :first, :top
#     alias_method :last, :bottom
#   end
class AbstractStack

  extend Forwardable
  
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
  # @return [value]
  def push(value)
    raise OverFlow if limit && (limit <= length)
    
    @list.push value
    self
  end

  alias_method :<<, :push

  def pop
    raise UnderFlow if empty?
      
    @list.pop
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
    (self.class == other.class) && (@list == other._list)
  end
  
  def eql?(other)
    (self.class == other.class) && 
      [limit, _list].eql?([other.limit, other._list])
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
