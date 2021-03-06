# coding: us-ascii

require_relative 'helper'

class TestAbstractStack < Test::Unit::TestCase

  FIFO = AbstractStack::FIFO
  LIFO = AbstractStack::LIFO

  def test_fifo
    stack = FIFO.new

    assert_equal nil, stack.limit

    assert_equal nil, stack.bottom
    assert_equal nil, stack.top
    assert_equal 0, stack.length

    assert_raises FIFO::UnderFlow do
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

    assert_equal 1, stack[0]
    assert_equal 1, stack[-2]
    assert_equal 'String', stack[1]
    assert_equal 'String', stack[-1]

    assert_raises IndexError do
      stack[2]
    end

    assert_raises IndexError do
      stack[-3]
    end

    assert_equal '#<AbstractStack::FIFO limit=nil [1, "String"]>', stack.inspect

    stack2 = FIFO.new
    stack2 << 1
    assert_same false, stack == stack2
    assert_same false, stack.eql?(stack2)
    stack2 << 'String'
    assert_same true, stack == stack2
    assert_same true, stack.eql?(stack2)
    assert_same true, {stack => true}.has_key?(stack2)

    stack3 = FIFO.new 3
    stack3 << 1 << 'String'
    assert_same true, stack == stack3
    assert_same false, stack.eql?(stack3)
    assert_same false, {stack => true}.has_key?(stack3)

    stack4 = stack3.dup
    assert_equal 3, stack4.limit
    assert_same true, stack3 == stack4
    stack4 << :sth
    assert_same false, stack3 == stack4

    enum = stack.each
    assert_kind_of Enumerable, enum
    assert_equal 1, enum.next
    assert_equal 'String', enum.next
    assert_raises StopIteration do
      enum.next
    end
    assert_equal enum.size, enum.to_a.each.size

    assert_same stack, stack.each{|v|v}

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

  def test_fifo_to_h
    stack = FIFO.new
    stack << [:key1, :value1]
    stack << [:key2, :value2]
    assert_equal stack.to_h, [[:key1, :value1], [:key2, :value2]].to_h
  end

  def test_sizelimit
    stack = FIFO.new 2

    assert_equal 2, stack.limit
    stack << 4 << 7

    assert_equal '#<AbstractStack::FIFO limit=2 [4, 7]>', stack.inspect

    assert_raises FIFO::OverFlow do
      stack << 9
    end

    assert_equal 2, stack.length
  end

  def test_freeze
    stack = FIFO.new 2
    stack << 1
    stack.freeze

    assert_raises FrozenError do
      stack.pop
    end

    assert_raises FrozenError do
      stack << 1
    end
  end

  def test_lifo
    stack = LIFO.new

    stack << 1 << 'String'

    assert_equal 'String', stack[0]
    assert_equal 'String', stack[-2]

    assert_equal 1, stack[1]
    assert_equal 1, stack[-1]

    assert_raises IndexError do
      stack[2]
    end

    assert_raises IndexError do
      stack[-3]
    end

    enum = stack.each
    assert_kind_of Enumerable, enum
    assert_equal 'String', enum.next
    assert_equal 1, enum.next
    assert_raises StopIteration do
      enum.next
    end
    assert_equal enum.size, enum.to_a.each.size

    stack2 = LIFO.new
    stack2 << 1 << 7
    assert_equal [14, 2], stack2.map{|v|v * 2}

    assert_equal 7, stack2[0]
  end

  def test_lifo_to_h
    stack = LIFO.new
    stack << [:key1, :value1]
    stack << [:key2, :value2]
    assert_equal stack.to_h, [[:key1, :value1], [:key2, :value2]].to_h
  end

end
