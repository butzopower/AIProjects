class Player
  # ruby utility method for creating setters and getters
  attr_accessor :opponent, :score, :row

  def initialize(row_array, score)
    self.row = Row.new(row_array, self)
    self.score = score
  end
end
