# coding: us-ascii

class AbstractStack

  class FIFO < self

    alias_method :each, :fifo_each
    alias_method :reverse_each, :filo_each

    private

    def _index_for(pos)
      pos
    end

  end

  LILO = FIFO

end
