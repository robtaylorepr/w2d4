require 'minitest/autorun'
require_relative 'deck'
require_relative 'card'

class DeckTest < MiniTest::Test

  def test_deck_has_52_cards
    deck = Deck.new
    assert_equal 52, deck.cards.length
    assert deck.cards.all?{ |card| card.is_a? Card }
  end

  def test_deck_contains_13_of_each_suit
    deck = Deck.new
    Card.suits.each do |suit|
      assert_equal 13, deck.cards.select { |card| card.suit == suit }.count
    end
  end

  def test_deck_contains_4_of_each_face
    deck = Deck.new
    Card.faces.each do |face|
      assert_equal 4, deck.cards.select { |card| card.face == face }.count
    end
  end

  def test_deck_is_shuffled
    deck_one = Deck.new.cards
    deck_two = Deck.new.cards
    assert deck_one != deck_two
  end

  def test_card_can_be_drawn_from_deck
    deck = Deck.new
    deck.draw_card
    assert_equal 51, deck.cards.length
    assert deck.cards.all?{ |card| card.is_a? Card }
  end
end
