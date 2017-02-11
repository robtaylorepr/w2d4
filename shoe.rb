require_relative 'card'
require_relative 'deck'

class Shoe < Deck

  def make_cards
    deck = []
    7.times { deck << Deck.new.cards }
    deck
  end

end
