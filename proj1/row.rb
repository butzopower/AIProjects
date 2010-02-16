class Row
  attr_accessor :player, :houses

  def initialize(houses, player)
    self.houses = houses
    self.player = player
  end

  # initial call to start moving pieces
  def apply(position)
    remaining = houses[position] # get the number of pieces
    self.houses[position] = 0 # empty out the house
    (position + 1).upto(5) do |pos| # for all houses remaining on our row
      if remaining > 0              # while we still have pieces
        self.houses[pos] += 1              # increase them by one
        remaining -= 1                # decrease remaining by one
      end
    end

    if remaining > 0
      self.player.opponent.row.apply_moves_from_player(self.player, position, remaining)
    end
  end

  def apply_moves_from_player(applying_player, applied_position, remaining)

    range = (0..5).to_a                                   # create an array 0 to 5
    range -= [applied_position] if self.player == applying_player # skip the one we emptied 
                                                          #if we are the applying player
    
    range = range.first(remaining) # get as many as we have remaining, or all of them

    range.each do |pos|
      self.houses[pos] += 1
      remaining -= 1
    end

    if remaining == 0 && self.player == applying_player.opponent
      score_for_player_at_position(applying_player, range.last)
    end

    if remaining > 0
      self.player.opponent.row.apply_moves_from_player(applying_player, applied_position, remaining)
    end
  end

  def score_for_player_at_position(player, position)
    unless position == 5 && houses.all?{|x| x >= 2 && x <= 3} # don't do anything if we would wipe the whole board
      while position >= 0 && (houses[position] == 2 || houses[position] == 3)
        player.score += houses[position]
        houses[position] = 0
        position -= 1
      end
    end
  end
end
