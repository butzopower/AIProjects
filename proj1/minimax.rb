module Minimax

  def self.infinity
    # ruby will make infinity for you
    1.0 / 0.0
  end

  def self.minimax(board, horizon)
    self.search(board, board.first_player, horizon)
  end
  
  def self.search(board, player, horizon)
    # lost if opponent won
    return -infinity if board.won_by?(player.opponent)

    return board.evaluate_for_player(player) if horizon == 0

    return board.boards_for_moves_of_player(player).map {|board| -self.search(board, player.opponent, horizon -1)}.max
  end

end
