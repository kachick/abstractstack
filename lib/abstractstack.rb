# Copyright (C) 2012 Kenichi Kamiya

require 'forwardable'

class AbstractStack
  VERSION = '0.0.1'.freeze

  class InvalidStackOperation < StandardError; end

  class << self

    alias_method :_new, :new
    private :_new

    # @return [Class]
    def new(&block)
      ::Class.new(self) {
        class_eval(&block) if block_given?
      }
    end

    private

    alias_method :_inherited, :inherited
    
    def inherited(subclass)
      subclass.class_eval do

        _inherited subclass
        extend Forwardable

        const_set :UnderFlow, Class.new(InvalidStackOperation)
        const_set :OverFlow,  Class.new(InvalidStackOperation)

        singleton_class.class_eval do
          alias_method :new, :_new
          undef_method :_new
          public :new

          alias_method :inherited, :_inherited
          undef_method :_inherited
          private :inherited
        end

        attr_reader :limit
       
        def initialize(limit=nil)
          @list = []

          case limit
          when nil, 0, false
            @limit = nil
          when ->v{(v >= 1) && v.kind_of?(Integer)}
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
            raise self.class::OverFlow
          else
            @list.push value
            self
          end
        end

        alias_method :<<, :push
 
        # @return [Object]
        def pop
          if empty?
            raise self.class::UnderFlow
          else
            @list.pop
          end
        end
 
        # @return [self]
        def each
          return to_enum(__callee__) unless block_given?

          @list.each{|v|yield v}
          self
        end

        # @return [self]
        def reverse_each
          return to_enum(__callee__) unless block_given?

          @list.reverse_each{|v|yield v}
          self
        end

        alias_method :lifo_each, :reverse_each
        alias_method :filo_each, :reverse_each

        # @return [Array]
        def to_a
          @list.dup
        end

        # @return [self]
        def freeze
          @list.freeze
          super
        end

        private

        def initialize_copy(original)
          @list = @list.dup
        end
        
      end
    end

  end
  


end
