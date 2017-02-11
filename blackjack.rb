require_relative 'shoe'
require_relative 'game_logic'
require 'tty'

class Game
  include GameLogic

  attr_accessor :deck,
                :player_hand,
                :dealer_hand,
                :prompt,
                :shoe

  def initialize
    @shoe = Shoe.new
    @prompt = TTY::Prompt.new
    @player_hand = []
    @dealer_hand = []
    play_blackjack
  end

  def deal_cards
    2.times do
      @player_hand << shoe.draw_card
      @dealer_hand << shoe.draw_card
    end
  end

  def check_dealer_hand
    if blackjack?(dealer_hand)
      show_dealer_hand
      puts "YOU LOST"
      play_again?
    else
      #new method: show first card
      puts "\nDealer reveals:"
      puts "#{dealer_hand.last.face} of #{dealer_hand.last.suit}"
    end
  end

  def show_dealer_hand
    puts "\nDealer hand:"
    dealer_hand.each do |card|
      puts "#{card.face} of #{card.suit}"
    end
  end

  def show_player_hand
    puts "\nYour hand:"
    player_hand.each do |card|
      puts "#{card.face} of #{card.suit}"
    end
  end

  def play_blackjack
    deal_cards
    check_dealer_hand
    until end_player_turn
      show_player_hand
      response = prompt.select("Would you like to hit or stay?", %w(hit stay))
      if response == "hit"
        @player_hand << shoe.draw_card
        check_for_ace(player_hand)
        show_player_hand
      else
        break
      end
    end

    until end_dealer_turn
      @dealer_hand << shoe.draw_card
      check_for_ace(dealer_hand)
    end
    determine_winner
  end

  def determine_winner
    if player_wins?
      show_dealer_hand
      puts "YOU WON"
    else
      show_dealer_hand
      puts "YOU LOST"
    end
    play_again?
  end

  def play_again?
    response = prompt.select("Would you like to play again?", %w(Yes No))
    (response == "Yes") ? Game.new : (puts "Goodbye!")
  end

end

Game.new
