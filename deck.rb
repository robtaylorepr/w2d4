require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize
    @cards = make_cards.flatten
    @cards.shuffle!
  end

  def make_cards
    Card.faces.map do |face|
      Card.suits.map do |suit|
        Card.new(face, suit)
      end
    end
  end

  def draw_card
    cards.shift
  end

end
