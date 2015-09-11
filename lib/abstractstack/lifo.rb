# coding: us-ascii

class AbstractStack

  class LIFO < self

    alias_method :each, :lifo_each
    alias_method :reverse_each, :fifo_each

    private

    def _index_for(pos)
      (-pos) - 1
    end

  end

  FILO = LIFO

end
