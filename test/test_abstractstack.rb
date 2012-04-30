$VERBOSE = true
require_relative 'test_helper'

class TestAbstractStack < Test::Unit::TestCase
  
  SimpleStack = AbstractStack.new

  EnumStack   = AbstractStack.new do
    include Enumerable
  end
  
  def test_normaly
    stack = SimpleStack.new

    assert_equal nil, stack.limit

    assert_equal nil, stack.bottom
    assert_equal nil, stack.top
    assert_equal 0, stack.length

    assert_raises SimpleStack::UnderFlow do
      stack.pop
    end

    assert_equal nil, stack.bottom
    assert_equal nil, stack.top
    assert_equal 0, stack.length

    assert_equal stack, (stack << 1)
    assert_equal 1, stack.bottom
    assert_equal 1, stack.peek
    assert_equal 1, stack.top
    assert_equal 1, stack.length
    assert_equal stack, (stack << 'String')
    assert_equal 2, stack.size
    assert_equal [1, 'String'], stack.to_a
    assert_equal 1, stack.bottom
    assert_equal 'String', stack.top

    enum = stack.each
    assert_kind_of Enumerable, enum
    assert_equal 1, enum.next
    assert_equal 'String', enum.next
    assert_raises StopIteration do
      enum.next
    end

    enum = stack.lifo_each
    assert_kind_of Enumerable, enum
    assert_equal 'String', enum.next
    assert_equal 1, enum.next
    assert_raises StopIteration do
      enum.next
    end

    assert_equal 'String', stack.pop
    assert_equal 1, stack.bottom
    assert_equal 1, stack.top
    assert_equal 1, stack.length

    assert_equal 1, stack.pop
    assert_equal nil, stack.bottom
    assert_equal nil, stack.top
    assert_equal 0, stack.length
  end


  def test_sizelimit
    stack = SimpleStack.new 2
    
    assert_equal 2, stack.limit
    stack << 4 << 7
    
    assert_raises SimpleStack::OverFlow do
      stack << 9
    end

    assert_equal 2, stack.length
  end

  def test_abstract
    stack = EnumStack.new
    stack << 1 << 5 << 9
    assert_equal [2, 10, 18], stack.map{|v|v * 2}
  end

end
