$VERBOSE = true

require_relative '../lib/abstractstack'

# * Simply

    class Stack < AbstractStack; end
    stack = Stack.new
    stack.push 1
    stack << 7
    p stack         #=> #<Stack limit=nil [1, 7]>
    p stack.top     #=> 7
    p stack.bottom  #=> 1
    stack.pop       #=> 7
    stack.pop       #=> 1
    p stack         #=> #<Stack limit=nil []>
    p stack.to_a    #=> []
    #stack.pop      #=> Exception(UnderFlow)

# * Size limitation
  
    stack = Stack.new 2
    p stack.limit         #=> 2
    stack << 1 << 7
    #stack << 9           #=> Exception(Overflow)

# * You can get your extended Stack class

    class LIFO < AbstractStack
      include Enumerable

      alias_method :each, :lifo_each
      alias_method :reverse_each, :fifo_each
      alias_method :first, :top
      alias_method :last, :bottom

      def at(pos)
        super pos, :top
      end
    end

    stack = LIFO.new

    stack << 1 << 7
    p stack.map{|v|v * 2} #=> [14, 2]
