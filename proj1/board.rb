class Board
  # ruby utility method for creating setters and getters
  attr_accessor :player_one, :player_two

  def initialize(board_state, player_one, player_two)
    player_one.opponent = player_two
    player_two.opponent = player_one
  end

  def won_by?(player)
    player.score > 24 
  end

  def evaluate_for_player(player)
    player.score - player.opponent.score
  end

  def boards_for_moves_of_player(player)
    
  end
  
end
