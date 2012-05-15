class AbstractStack

  class InvalidStackOperation < StandardError; end
  class UnderFlow < InvalidStackOperation; end
  class OverFlow  < InvalidStackOperation; end

end
