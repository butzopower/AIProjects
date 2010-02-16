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

  def evaluate_for_player(player) # the BSE, based on the difference of the scores
    player.score - player.opponent.score 
  end

  def boards_for_moves_of_player(player)
    valid_moves = (0..5).to_a.select{|x| player.row.houses[x] > 0} # can't make moves for 0

    if valid_moves.empty? # game is over, can't make valid move
      # score is current score plus all pieces
      #
      
      p1_score = player.score + player.row.houses.inject(0){|x, y| x + y}
      p2_score = player.opponent.score + player.opponent.row.houses.inject(0){|x, y| x + y} 

      new_player1 = Player.new(Array.new(6){0}, p1_score) # player with new score and board of 6 0s
      new_player2 = Player.new(Array.new(6){0}, p2_score) # player with new score and board of 6 0s
      return [[Board.new(new_player1, new_player2), nil]] # hopefully Board will figure out somebody won
    end

    valid_moves.map do |x|
      new_player1 = Player.new(player.row.houses, player.score)
      new_player2 = Player.new(player.opponent.row.houses, player.opponent.score)
      board = Board.new(new_player1, new_player2) # need to do this first to setup opponents
      new_player1.row.apply(x) 
      [board, x+1]
    end 
  end
  
end
