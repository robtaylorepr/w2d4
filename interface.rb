require_relative 'blackjack'
require 'tty'

class Interface
  attr_accessor :prompt

  def initialize
    @prompt = TTY::Prompt.new
  end

  def new_game
    response = prompt.select("Would you like to play a game?", %w(Yes No))
    (response == "Yes") ? Game.new.play_blackjack : (puts "Goodbye.")
  end

end

Interface.new.new_game
