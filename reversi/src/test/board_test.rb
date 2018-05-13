require 'minitest/autorun'
require_relative '../board'
require_relative '../stone'
require_relative '../player/human'

class BoardTest < Minitest::Test
  include Stone
  include PosMoveMap

  def test_board_index
    board = Board.new()
    assert_equal Stone::WHITE, board.board[4][4]
    assert_equal Stone::BLACK, board.board[4][5]
    assert_equal Stone::NONE, board.board[2][6]
    refute_equal Stone::BLACK, board.board[6][2]
  end

  def test_board_index_update
    board = Board.new()
    assert_equal Stone::NONE, board.board[2][6]
    board.board[2][6] = Stone::BLACK
    assert_equal Stone::BLACK, board.board[2][6]
  end

  def test_board_get_flip
    board = Board.new()
    right = board.get_flip(Stone::BLACK, [4, 3], [0, 1])
    assert_equal 1, right
    left = board.get_flip(Stone::WHITE, [4, 6], [0, -1])
    assert_equal 1, left
    up = board.get_flip(Stone::WHITE, [6, 4], [-1, 0])
    assert_equal 1, up
    bottom = board.get_flip(Stone::BLACK, [3, 4], [1, 0])
    assert_equal 1, bottom
  end

  def test_board_get_flips
    board = Board.new()
    flips = board.get_flips(Stone::BLACK, [4, 3])
    flips_expect = [0, 0, 0, 0, 1, 0, 0, 0]
    ## +---+---+---+
    ## | 0 | 0 | 0 |
    ## +---+---+---+
    ## | 0 | * | 1 |
    ## +---+---+---+
    ## | 0 | 0 | 0 |
    ## +---+---+---+
    assert_equal flips, flips_expect
    flips = board.get_flips(Stone::WHITE, [6, 4])
    flips_expect = [0, 1, 0, 0, 0, 0, 0, 0]
    ## +---+---+---+
    ## | 0 | 1 | 0 |
    ## +---+---+---+
    ## | 0 | * | 0 |
    ## +---+---+---+
    ## | 0 | 0 | 0 |
    ## +---+---+---+
    assert_equal flips, flips_expect
  end

  def test_board_moves
    board = Board.new()
    moves_expect = []
    board_map_expect = PosMoveMap::MAP
    moves = board.moves(Stone::BLACK)
    moves_expect.push(board_map_expect.new([3, 4], [0, 0, 0, 0, 0, 0, 1, 0]))
    ## +---+---+---+
    ## | 0 | 0 | 0 |
    ## +---+---+---+
    ## | 0 | * | 0 |
    ## +---+---+---+
    ## | 0 | 1 | 0 |
    ## +---+---+---+
    moves_expect.push(board_map_expect.new([4, 3], [0, 0, 0, 0, 1, 0, 0, 0]))
    ## +---+---+---+
    ## | 0 | 0 | 0 |
    ## +---+---+---+
    ## | 0 | * | 1 |
    ## +---+---+---+
    ## | 0 | 0 | 0 |
    ## +---+---+---+
    moves_expect.push(board_map_expect.new([5, 6], [0, 0, 0, 1, 0, 0, 0, 0]))
    ## +---+---+---+
    ## | 0 | 0 | 0 |
    ## +---+---+---+
    ## | 1 | * | 0 |
    ## +---+---+---+
    ## | 0 | 0 | 0 |
    ## +---+---+---+
    moves_expect.push(board_map_expect.new([6, 5], [0, 1, 0, 0, 0, 0, 0, 0]))
    ## +---+---+---+
    ## | 0 | 1 | 0 |
    ## +---+---+---+
    ## | 0 | * | 0 |
    ## +---+---+---+
    ## | 0 | 0 | 0 |
    ## +---+---+---+
    assert moves==moves_expect, "moves"
  end

  def test_board_stone_count
    board = Board.new()
    assert_equal 2, board.count_stone(Stone::BLACK)
    board.board[4][4] = Stone::BLACK
    assert_equal 3, board.count_stone(Stone::BLACK)
    assert_equal 1, board.count_stone(Stone::WHITE)
    human = Human.new(Stone::BLACK)
    assert_equal 3, board.count_stone(human.stone)
  end

  def test_board_do_flip
    board = Board.new()
    board.do_flip(Stone::BLACK, [4, 3], [0, 1], 1)
    assert_equal 3, board.count_stone(Stone::BLACK)
    assert_equal 1, board.count_stone(Stone::WHITE)
    n = Stone::NONE
    w = Stone::WHITE
    b = Stone::BLACK
    assert_equal board.board, [[n,n,n,n,n,n,n,n,n,n],
                               [n,n,n,n,n,n,n,n,n,n],
                               [n,n,n,n,n,n,n,n,n,n],
                               [n,n,n,n,n,n,n,n,n,n],
                               [n,n,n,n,b,b,n,n,n,n],
                               [n,n,n,n,b,w,n,n,n,n],
                               [n,n,n,n,n,n,n,n,n,n],
                               [n,n,n,n,n,n,n,n,n,n],
                               [n,n,n,n,n,n,n,n,n,n],
                               [n,n,n,n,n,n,n,n,n,n]]
  end

  def test_board_do_move
    board = Board.new()
    board.do_move(Stone::BLACK, PosMoveMap::MAP.new([3, 4], [0, 0, 0, 0, 0, 0, 1, 0]))
    assert_equal 4, board.count_stone(Stone::BLACK)
    assert_equal 1, board.count_stone(Stone::WHITE)
    n = Stone::NONE
    w = Stone::WHITE
    b = Stone::BLACK
    assert_equal board.board, [[n,n,n,n,n,n,n,n,n,n],
                               [n,n,n,n,n,n,n,n,n,n],
                               [n,n,n,n,n,n,n,n,n,n],
                               [n,n,n,n,b,n,n,n,n,n],
                               [n,n,n,n,b,b,n,n,n,n],
                               [n,n,n,n,b,w,n,n,n,n],
                               [n,n,n,n,n,n,n,n,n,n],
                               [n,n,n,n,n,n,n,n,n,n],
                               [n,n,n,n,n,n,n,n,n,n],
                               [n,n,n,n,n,n,n,n,n,n]]
  end

end