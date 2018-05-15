require_relative './player'

## さいきょうのAI
class Computer < Player
  def play(board)
    moves = board.moves(@stone)
    if moves.length == 0 then
      return nil
    end
    return moves[rand(moves.length)]
  end
end