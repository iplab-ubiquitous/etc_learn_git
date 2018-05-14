require_relative './player/human'
require_relative './board'
require_relative './stone'

class Game
  include Stone
  def initialize(p1, p2)
    @board = Board.new()
    @black = p1
    @white = p2
    @turn = @black
    @is_passed = false
  end

  def step
    move = @turn.play(@board)
    if !move.nil? then
      @board.do_move(@turn.stone, move)
      @black.set_stone_count(@board.count_stone(@black.stone))
      @white.set_stone_count(@board.count_stone(@white.stone))
      if @black.stone_count == 0 || @white.stone_count == 0 then
        return false
      end
      @is_passed = false
    else
      if @is_passed then
        return false
      end
      @is_passed = true
    end
    @turn = turn_over(@turn)
    return true
  end

  def print_score
    print "\nスコア #{@black.stone} #{@black.stone_count} - #{@white.stone} #{@white.stone_count}\n"
    @board.show_board
    puts "手番: #{@turn.stone}"

  end

  def turn_over(player)
    case player
      when @black
        @white
      when @white
        @black
    end
  end

end