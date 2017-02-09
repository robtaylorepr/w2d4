require_relative 'deck'
require 'tty'

class Game
  attr_accessor :deck,
                :player_one_hand,
                :player_two_hand,
                :prompt

  def initialize
    @deck = Deck.new
    @prompt = TTY::Prompt.new
    @player_one_hand = []
    @player_two_hand = []
    2.times do
      @player_one_hand << deck.draw_card
      @player_two_hand << deck.draw_card
    end
    reveal_first_card
  end

# Reveals first card
  def reveal_first_card
    puts "\nDealer reveals:"
    dealer_card = player_two_hand[0]
    puts "#{dealer_card.face} of #{dealer_card.suit}"
    puts "\nYou have:"
    show_player_hand
    calculate_player_hand
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

# Checks for initial win/loss
  def calculate_player_hand
    if total_hand(player_one_hand) == 21
      puts "YOU WON"
      play_again?
    elsif total_hand(player_one_hand) > 21
      show_dealer_hand
      puts "Bust! YOU LOST"
      play_again?
    else
      play_hand
    end
  end

# Play a hand
  def play_hand
    response = prompt.select("Would you like to hit or stay?", %w(hit stay))
    if response == "hit"
      @player_one_hand << deck.draw_card
      show_player_hand
      calculate_player_hand
    else
      play_dealer_hand
    end
  end

# Reveals dealer hand
  def show_dealer_hand
    puts "\nDealer hand:"
    player_two_hand.each do |card|
      puts "#{card.face} of #{card.suit}"
    end
    # play_dealer_hand
  end

# Calculates total of dealer hand
  def play_dealer_hand
    show_dealer_hand
    if total_hand(player_two_hand) > 21
      puts "YOU WON"
      play_again?
    elsif total_hand(player_two_hand) == total_hand(player_one_hand)
      puts "YOU WON"
      play_again?
    elsif total_hand(player_two_hand) > total_hand(player_one_hand)
      puts "YOU LOST"
    elsif total_hand(player_two_hand) < 16
      @player_two_hand << deck.draw_card
      play_dealer_hand
    else
      puts "YOU WON"
      play_again?
    end
  end

  def play_again?
    response = prompt.select("Would you like to play again?", %w(Yes No))
    if response == "Yes"
      Game.new
    else
      puts "Goodbye!"
    end
  end


end

Game.new
