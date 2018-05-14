require_relative './stone'

BOARD_SIZE = 8

ZERO_FLIP = [0, 0, 0, 0, 0, 0, 0, 0]
## 周囲に返せる石がない状態
## +---+---+---+
## | 0 | 0 | 0 |
## +---+---+---+
## | 0 | * | 0 |
## +---+---+---+
## | 0 | 0 | 0 |
## +---+---+---+

DIRECTIONS = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]] # 隣接する8方向へのベクトル
## +----------+----------+----------+
## | [-1, -1] | [-1,  0] | [-1, +1] |
## +----------+----------+----------+
## | [ 0, -1] | [*y, *x] | [ 0, +1] |
## +----------+----------+----------+
## | [+1, -1] | [+1,  0] | [+1, +1] |
## +----------+----------+----------+

module PosMoveMap
  MAP = Struct.new(:pos, :flips)
end

class Board
  include Stone
  include PosMoveMap

  def initialize()
    @board = Array.new(BOARD_SIZE + 2).map { Array.new(BOARD_SIZE + 2, Stone::NONE) }
    @board[4][4] = Stone::WHITE
    @board[5][5] = Stone::WHITE
    @board[4][5] = Stone::BLACK
    @board[5][4] = Stone::BLACK
  end

  def board
    @board
  end

  def show_board()
    print "    1 2 3 4 5 6 7 8\n"
    @board.slice(1...-1).each_with_index { |col, col_num|
      print((col_num+1).to_s + ": ")
      col.slice(1...-1).each { |row|
        print(" ")
        print(row)
      }
      print("\n")
    }
  end

  ## 指定した位置からdirection方向へ裏返せる数を走査
  def get_flip(stone, pos, direction)
    #flip_count = 0
    #next_column = pos[0]
    #next_row = pos[1]
    #loop do
    #  next_column += direction[0]
    #  next_row += direction[1]
    #  next_cell = @board[next_column][next_row]
    #  if next_cell == Stone::NONE then
    #    return 0
    #  elsif next_cell == stone then
    #    return flip_count
    #  end
    #  flip_count += 1
    #end
  end

  ## 指定した位置に石を置いた時に8方向の裏返せる数を得る
  def get_flips(stone, pos)
    #flips = []
    #if @board[pos[0]][pos[1]] == Stone::NONE then
    #  DIRECTIONS.each_with_index { |direction, i|
    #    flips.push(get_flip(stone, pos, direction))
    #  }
    #  return flips
    #else
    #  return ZERO_FLIP
    #end
  end

  ## 石を置くことができる場所の一覧を取得
  def moves(stone)
    #moves = []
    #@board[1...-1].each_with_index { |col, y|
    #  col[1...-1].each_with_index { |row, x|
    #    pos = [y+1, x+1]
    #    flips = get_flips(stone, pos)
    #    if flips != ZERO_FLIP then
    #      moves.push(PosMoveMap::MAP.new(pos, flips))
    #    end
    #  }
    #}
    #return moves
  end

  ## 指定した色で指定した場所から指定した方向へ指定回数石を裏返す
  def do_flip(stone, pos, direction, flip)
    #next_row = pos[1]
    #next_column = pos[0]
    #flip.times {
    #  next_row += direction[1]
    #  next_column += direction[0]
    #  @board[next_column][next_row] = stone
    #}
  end

  ## 指定した色で指定した場所に石を置く
  def do_move(stone, pos_move_map)
    #@board[pos_move_map.pos[0]][pos_move_map.pos[1]] = stone
    #pos_move_map.flips.zip(DIRECTIONS).each { |flip, direction|
    #  do_flip(stone, pos_move_map.pos, direction, flip)
    #}
  end

  def count_stone(stone)
    count = 0
    @board[1...-1].each_with_index { |col, y|
      col[1...-1].each_with_index { |row, x|
        if @board[(y+1)][(x+1)] == stone
          count += 1
        end
      }
    }
    return count
  end

end
