require 'minitest/autorun'
require_relative 'blackjack'

#top level documentation goes here
#and more here :-)
class BlackjackTest < MiniTest::Test

  def setup
    @game = Game.new
  end

  def test_deal_cards_gives_two_cards_each
    @game.deal_cards
    assert_equal 2, @game.player_hand.length
    assert_equal 2, @game.dealer_hand.length
  end

  def test_perform_hit_action_draws_card
    @game.deal_cards
    assert_equal 2, @game.player_hand.length
    @game.perform_hit_action(@game.player_hand)
    assert_equal 3, @game.player_hand.length
  end

  def test_perform_hit_action_changes_ace_value_when_bust
    @game.player_hand = [Card.new('Ace', 'Diamonds'), Card.new('9', 'Diamonds')]
    assert_equal 11, @game.player_hand.first.value
    @game.perform_hit_action(@game.player_hand)
    assert_equal 1, @game.player_hand.first.value
  end

end
