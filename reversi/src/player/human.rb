require_relative './player'
require_relative '../stone'

class Human < Player
  include Stone

  def initialize(stone)
    @stone = stone
    @stone_count = 0
  end

  def stone
    @stone
  end

  def stone_count
    @stone_count
  end

  def set_stone_count(count)
    @stone_count = count
  end

  def play(board)
    moves = board.moves(@stone)
    if moves.length == 0 then
      return nil
    end
    moves.each_with_index { |move, idx|
      print "(#{idx}) [#{move.pos[0]}, #{move.pos[1]}]\n"
    }
  end
end