require 'player/human'
require 'board'

class Game
  def initialize(board, p1, p2)
    @board = board
    @black = p1
    @white = p2
  end

end