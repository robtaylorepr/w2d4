require 'minitest/autorun'
require_relative 'shoe'
require_relative 'card'

class ShoeTest < MiniTest::Test

  def test_shoe_has_364_cards
    shoe = Shoe.new
    assert_equal 364, shoe.cards.length
    assert shoe.cards.all?{ |card| card.is_a? Card }
  end

  def test_shoe_contains_91_of_each_suit
    shoe = Shoe.new
    Card.suits.each do |suit|
      assert_equal 91, shoe.cards.select { |card| card.suit == suit }.count
    end
  end

  def test_shoe_contains_28_of_each_face
    shoe = Shoe.new
    Card.faces.each do |face|
      assert_equal 28, shoe.cards.select { |card| card.face == face }.count
    end
  end

  def test_shoe_is_shuffled
    shoe_one = Shoe.new.cards
    shoe_two = Shoe.new.cards
    assert shoe_one != shoe_two
  end

  def test_card_can_be_drawn_from_shoe
    shoe = Shoe.new
    shoe.draw_card
    assert_equal 363, shoe.cards.length
    assert shoe.cards.all?{ |card| card.is_a? Card }
  end
end
