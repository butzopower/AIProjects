class Row
  attr_accessor :player, :houses

  def initialize(houses, player)
    self.houses = houses
    self.player = player
  end

  # initial call to start moving pieces
  def apply(position)
    remaining = houses[position] # get the number of pieces
    houses[position] = 0 # empty out the house
    (position + 1).upto(5) do |pos| # for all houses remaining on our row
      if remaining > 0              # while we still have pieces
        houses[pos] += 1              # increase them by one
        remaining -= 1                # decrease remaining by one
      end
    end

    if remaining > 0
      player.opponent.row.apply_moves_from_player(player, position, remaining)
  end

  def apply_moves_from_player(applying_player, position, remaining)

  end

end
