require 'minitest/autorun'
require_relative 'card.rb'

class CardTest < MiniTest::Test

  def test_card_has_a_face_and_suit
    card = Card.new("2", "Clubs")
    assert_equal "2", card.face
    assert_equal "Clubs", card.suit
  end

  def test_card_have_value
    card = Card.new("2", "Clubs")
    assert_equal 2, card.value
  end

  def test_ace_has_value_of_11
    card = Card.new("Ace", "Clubs")
    assert_equal 11, card.value
  end

  def test_king_has_value_of_10
    card = Card.new("King", "Clubs")
    assert_equal 10, card.value
  end

  def test_queen_has_value_of_10
    card = Card.new("Queen", "Clubs")
    assert_equal 10, card.value
  end

  def test_jack_has_value_of_10
    card = Card.new("Jack", "Clubs")
    assert_equal 10, card.value
  end

end
