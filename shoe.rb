require_relative 'card'
require_relative 'deck'

class Shoe
  attr_accessor :cards

  def initialize
    @cards = make_cards.flatten
    @cards.shuffle!
  end

  def make_cards
    deck = []
    7.times { deck << Deck.new.cards }
    deck
  end

  def draw_card
    cards.shift
  end

end

Shoe.new
