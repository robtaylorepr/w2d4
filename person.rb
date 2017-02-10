class Player
  attr_accessor :games_played,
                :games_won

  def initialize
    @games_played = 0
    @games_won = 0
  end

  def win_game
    self.games_won += 1
  end

  def total_games
    self.games_played += 1
  end

end
