class Board
  # ruby utility method for creating setters and getters
  attr_accessor :first_player

  def initialize(player_one, player_two)
    player_one.opponent = player_two
    player_two.opponent = player_one
    self.first_player = player_one
  end

  def won_by?(player)
    player.score > 24 
  end

  def evaluate_for_player(player)
    player.score - player.opponent.score
  end

  def boards_for_moves_of_player(player)
    (0..5).to_a.map do |x|
      new_player1 = Player.new(player.row.houses, player.score)
      new_player2 = Player.new(player.opponent.row.houses, player.opponent.score)
      board = Board.new(new_player1, new_player2) # need to do this first to setup opponents
      new_player1.row.apply(x) 
      board
    end 
  end
  
end
