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
    return [-infinity, nil] if board.won_by?(player.opponent)

    return [board.evaluate_for_player(player), nil] if horizon == 0

    return board.boards_for_moves_of_player(player).compact.map do |new_board, move| 
             [-1 * self.search(new_board, new_board.first_player.opponent, horizon -1).first, move]
           end.max
  end

end
