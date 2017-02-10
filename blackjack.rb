require_relative 'deck'
require_relative 'shoe'
require_relative 'Person'
require 'tty'

class Game
  attr_accessor :deck,
                :player_one_hand,
                :player_two_hand,
                :prompt,
                :shoe,
                :player

  def initialize
    # @deck = Deck.new
    #replaced deck with shoe - need to see about inheritance
    @shoe = Shoe.new
    @player = Player.new
    @prompt = TTY::Prompt.new
    @player_one_hand = []
    @player_two_hand = []
    2.times do
      @player_one_hand << shoe.draw_card
      @player_two_hand << shoe.draw_card
    end
    reveal_card
  end

# Reveals first card
  def reveal_card
    if total_hand(player_two_hand) == 21 && total_hand(player_one_hand) == 21
      puts "YOU WON."
      player.win_game
      show_dealer_hand
      play_again?
    elsif total_hand(player_two_hand) == 21
      puts "YOU LOST. Dealer has 21."
      play_again?
    elsif total_hand(player_two_hand) < 21
      puts "\nDealer reveals:"
      puts "#{player_two_hand.last.face} of #{player_two_hand.last.suit}"
      puts "\nYou have:"
      show_player_hand
      calculate_player_hand
    end
  end

# Reveals player hand
  def show_player_hand
    player_one_hand.each do |card|
      puts "#{card.face} of #{card.suit}"
    end
  end

# Calculates total value of hand
  def total_hand(player_hand)
    player_hand.inject(0) { |sum, card| sum += card.value }
  end

# Reveals dealer hand
  def show_dealer_hand
    puts "\nDealer hand:"
    player_two_hand.each do |card|
      puts "#{card.face} of #{card.suit}"
    end
  end

# Checks for initial win/loss
  def calculate_player_hand
    if total_hand(player_one_hand) == 21
      puts "YOU WON"
      # player.win_game
      play_again?
    elsif total_hand(player_one_hand) > 21
      # I don't know if show_dealer_hand is necessary here - confuses output
      # show_dealer_hand
      puts "Bust! YOU LOST"
      play_again?
    elsif player_one_hand.length > 5
      puts "YOU WON"
      # player.win_game
    else
      play_player_hand
    end
  end

# Play a hand
  def play_player_hand
    response = prompt.select("Would you like to hit or stay?", %w(hit stay))
    if response == "hit"
      @player_one_hand << shoe.draw_card
      show_player_hand
      calculate_player_hand
    else
      play_dealer_hand
    end
  end

# Calculates total of dealer hand
  def play_dealer_hand
    show_dealer_hand
    if total_hand(player_two_hand) > 21
      puts "YOU WON"
      # player.win_game
      play_again?
    elsif total_hand(player_two_hand) == total_hand(player_one_hand)
      hands_tied?
    elsif total_hand(player_two_hand) > total_hand(player_one_hand)
      puts "YOU LOST"
      play_again?
    elsif total_hand(player_two_hand) < 16
      @player_two_hand << shoe.draw_card
      play_dealer_hand
    else
      puts "YOU WON"
      # player.win_game
      play_again?
    end
  end

  def hands_tied?
    p1_length = player_one_hand.length
    p2_length = player_two_hand.length
    if p1_length < p2_length
      puts "YOU LOST"
      play_again?
    else
      puts "YOU WON"
      # player.win_game
      play_again?
    end
  end

# Asks to play again
  def play_again?
    # player.total_games
    response = prompt.select("Would you like to play again?", %w(Yes No))
    if response == "Yes"
      Game.new
    else
      puts "Goodbye!"
    #   puts "Games you've played: #{player.games_played}"
    #   puts "Games you've won: #{player.games_won}"
    end
  end
end

Game.new
