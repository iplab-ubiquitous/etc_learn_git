class Player
  def initialize(stone)
    @stone = stone
    @stone_count = 2
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

  def play
  end
end