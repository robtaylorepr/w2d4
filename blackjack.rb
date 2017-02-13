require_relative 'shoe'
require_relative 'game_logic'
require 'tty'

# Game class for Blackjack game_logic
#  Description of function
#  Description of other objects it uses
class Game
  include GameLogic

  @winners_array = []

  class << self
    attr_accessor :winners_array
  end

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
  end

  def show_hands
    return unless blackjack?(dealer_hand) do
      show_dealer_card
      show_player_hand
    end
  end

  def player_plays
    until end_player_turn
      response = prompt.select('Would you like to hit or stay?', %w(hit stay))
      break unless response == 'hit'
      perform_hit_action(player_hand)
      show_player_hand
    end
  end

  def dealer_plays
    perform_hit_action(dealer_hand) until end_dealer_turn
  end

  def play_blackjack
    deal_cards
    show_hands
    player_plays
    dealer_plays
    determine_winner
  end

  def perform_hit_action(hand)
    hand << draw_card
    check_for_ace(hand) if bust?(hand)
  end

  def deal_cards
    2.times do
      @player_hand << shoe.draw_card
      @dealer_hand << shoe.draw_card
    end
  end

  def draw_card
    shoe.draw_card
  end

  def show_dealer_card
    puts "\nDealer reveals:"
    puts "#{dealer_hand.last.face} of #{dealer_hand.last.suit}"
  end

  def show_dealer_hand
    puts "\nDealer hand:"
    show_cards(dealer_hand)
  end

  def show_player_hand
    puts "\nYour hand:"
    show_cards(player_hand)
  end

  def show_cards(hand)
    hand.each do |card|
      puts "#{card.face} of #{card.suit}"
    end
  end

  def determine_winner
    show_dealer_hand
    player_wins? ? winning_message : losing_message
    play_again?
  end

  def winning_message
    puts 'YOU WON!'
    Game.winners_array << 'Player'
  end

  def losing_message
    puts 'YOU LOST.'
    Game.winners_array << 'Dealer'
  end

  def play_again?
    response = prompt.select('Would you like to play again?', %w(Yes No))
    response == 'Yes' ? Game.new.play_blackjack : puts_game_totals
  end

  def puts_game_totals
    puts "You won #{games_won} out of #{games_played} games!"
  end

  def games_won
    Game.winners_array.count { |entry| entry == 'Player' }
  end

  def games_played
    Game.winners_array.length
  end
end
