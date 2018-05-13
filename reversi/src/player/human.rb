require_relative './player'

class Human < Player
  def play(board)
    moves = board.moves(@stone)
    if moves.length == 0 then
      return nil
    end

    puts "選択肢:"
    moves.each_with_index { |move, idx|
      print "(#{idx}) [#{move.pos[0]}, #{move.pos[1]}]\n"
    }
    loop {
      print "選択肢番号を入力してください: "
      input = gets
      if input.to_i < moves.length then
        return moves[input.to_i]
      end
    }
  end
end