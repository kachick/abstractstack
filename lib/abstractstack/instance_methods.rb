# coding: us-ascii

class AbstractStack

  extend Forwardable
  
  attr_reader :limit
 
  # @param limit [Integer]
  def initialize(limit=nil)
    @list = []
    @limit = _limit_for limit
  end

  def_delegators :@list, :length, :size, :empty?
  def_delegator  :@list, :first, :bottom
  def_delegator  :@list, :last, :top
  def_delegator  :@list, :last, :peek

  # @return [value]
  # @raise [OverFlow] if over the limit size of self
  def push(value)
    raise OverFlow if limit && (limit <= length)
    
    @list.push value
    self
  end

  alias_method :<<, :push

  # @raise [UnderFlow] if self is empty when you call
  def pop
    raise UnderFlow if empty?
      
    @list.pop
  end

  # @yield [value]
  # @yieldreturn [self]
  # @return [Enumerator]
  def fifo_each
    return to_enum(__callee__) unless block_given?

    @list.each{|v|yield v}
    self
  end
  
  alias_method :lilo_each, :fifo_each

  # @yield [value]
  # @yieldreturn [self]
  # @return [Enumerator]
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
  
  def _limit_for(limit)
    case limit
    when nil, 0, false
      nil
    when ->v{v.integer? && (v >= 1)}
      limit.to_int
    else
      raise TypeError
    end
  end

end
