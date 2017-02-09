require 'minitest/autorun'
require_relative 'blackjack'

class BlackjackTest < MiniTest::Test

  def test_player_one_has_two_cards
    game = Game.new
    assert_equal 2, game.player_one_hand.length
  end

  def test_player_two_has_two_cards
    game = Game.new
    assert_equal 2, game.player_two_hand.length
  end

  def test_if_two_Aces_lose_game
    
  end

end
