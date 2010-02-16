module Minimax

  def self.infinity
    # ruby will make infinity for you
    1.0 / 0.0
  end

  def self.minimax(board, horizon)
    self.search(board, board.first_player, horizon)
  end

  def self.search(board, player, horizon)
    $calls_to_search += 1
    # lost if opponent won
    return [-infinity, nil] if board.won_by?(player.opponent)

    # hit the horizon, return BSE
    return [board.evaluate_for_player(player), nil] if horizon == 0

    # play out all available moves and get their score, maximize
    return board.boards_for_moves_of_player(player).compact.map do |new_board, move| 
             [-1 * self.search(new_board, new_board.first_player.opponent, horizon -1).first, move]
           end.max
  end

  def self.alpha_beta_minimax(board, horizon)
    self.absearch(board, board.first_player, horizon, -infinity, infinity)
  end

  def self.absearch(board, player, horizon, alpha, beta)
    $calls_to_search += 1
    # lost if opponent won
    return [alpha, nil] if board.won_by?(player.opponent)

    # hit the horizon, return BSE
    return [board.evaluate_for_player(player), nil] if horizon == 0

    # for each possible move, search that move, if the alpha value is greater than beta, that's the best we can do
    board.boards_for_moves_of_player(player).compact.each do |new_board, move|
      alpha = [alpha, -1 * self.absearch(new_board, new_board.first_player.opponent, horizon-1, -alpha, -beta).first].max
      return [alpha, move] if alpha >= beta
    end

    return [alpha, nil]

  end

end
