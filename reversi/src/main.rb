require_relative './player/human'
require_relative './player/computer'
require_relative './board'
require_relative './game'
require_relative './stone'

include Stone

p1 = Human.new(Stone::BLACK)
p2 = Computer.new(Stone::WHITE)
game = Game.new(p1, p2)

loop {
  game.print_score
  finish_flag = game.step
  if !finish_flag then
    break
  end
}

