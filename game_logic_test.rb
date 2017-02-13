require 'minitest/autorun'
require_relative 'blackjack'
require_relative 'game_logic'


class GameLogicTest < MiniTest::Test

  def setup
    @game = Game.new
  end

  def test_hand_with_value_21_is_blackjack
    hand = [Card.new("Ace", "Diamonds"), Card.new("Queen", "Diamonds")]
    assert @game.blackjack?(hand)
  end

  def test_hand_with_value_over_21_is_bust
    hand = [Card.new("Ace", "Diamonds"), Card.new("Queen", "Diamonds"), Card.new("10", "Diamonds")]
    assert @game.bust?(hand)
  end

  def test_value_of_ace_can_be_1_or_11
    card = Card.new("Ace", "Diamonds")
    hand = [card]
    assert_equal 11, card.value
    @game.check_for_ace(hand)
    assert_equal 1, card.value
  end

  def test_blackjack_of_player_hand_ends_dealer_turn
    hand = [Card.new("Ace", "Diamonds"), Card.new("Queen", "Diamonds")]
    @game.player_hand = hand
    assert @game.end_dealer_turn
  end

  def test_bust_of_player_hand_ends_dealer_turn
    hand = [Card.new("Ace", "Diamonds"), Card.new("Queen", "Diamonds"), Card.new("10", "Diamonds")]
    @game.player_hand = hand
    assert @game.end_dealer_turn
  end

  def test_bust_of_dealer_hand_ends_dealer_turn
    hand = [Card.new("Ace", "Diamonds"), Card.new("Queen", "Diamonds"), Card.new("10", "Diamonds")]
    @game.dealer_hand = hand
    assert @game.end_dealer_turn
  end

  def test_blackjack_of_dealer_hand_ends_dealer_turn
    hand = [Card.new("Ace", "Diamonds"), Card.new("Queen", "Diamonds")]
    @game.dealer_hand = hand
    assert @game.end_dealer_turn
  end

  def test_value_of_dealer_hand_greater_than_15_ends_dealer_turn
    hand = [Card.new("6", "Diamonds"), Card.new("Queen", "Diamonds")]
    @game.dealer_hand = hand
    assert @game.end_dealer_turn
  end

  def test_blackjack_of_dealer_hand_ends_player_turn
    hand = [Card.new("Ace", "Diamonds"), Card.new("Queen", "Diamonds")]
    @game.dealer_hand = hand
    assert @game.end_player_turn
  end

  def test_bust_of_player_hand_ends_player_turn
    hand = [Card.new("Ace", "Diamonds"), Card.new("Queen", "Diamonds"), Card.new("10", "Diamonds")]
    @game.player_hand = hand
    assert @game.end_player_turn
  end

  def test_blackjack_of_player_hand_ends_player_turn
    hand = [Card.new("Ace", "Diamonds"), Card.new("Queen", "Diamonds")]
    @game.player_hand = hand
    assert @game.end_player_turn
  end

  def test_player_loses_if_player_busts
    hand = [Card.new("Ace", "Diamonds"), Card.new("Queen", "Diamonds"), Card.new("10", "Diamonds")]
    @game.player_hand = hand
    assert !@game.player_wins?
  end

  def test_player_loses_if_both_draw_blackjack
    hand = [Card.new("Ace", "Diamonds"), Card.new("Queen", "Diamonds")]
    @game.player_hand = hand
    @game.dealer_hand = hand
    assert !@game.player_wins?
  end

  def test_player_wins_with_blackjack
    hand1 = [Card.new("Ace", "Diamonds"), Card.new("Queen", "Diamonds")]
    hand2 = [Card.new("9", "Diamonds"), Card.new("Queen", "Diamonds")]
    @game.player_hand = hand1
    @game.dealer_hand = hand2
    assert @game.player_wins?
  end

  def test_player_wins_tie_with_more_cards
    hand1 = [Card.new("3", "Diamonds"), Card.new("Queen", "Diamonds"), Card.new("7", "Diamonds")]
    hand2 = [Card.new("10", "Diamonds"), Card.new("Queen", "Diamonds")]
    @game.player_hand = hand1
    @game.dealer_hand = hand2
    assert @game.player_wins?
  end

  def test_player_wins_tie_with_same_number_of_cards
    hand1 = [Card.new("10", "Diamonds"), Card.new("Queen", "Diamonds")]
    hand2 = [Card.new("10", "Diamonds"), Card.new("Queen", "Diamonds")]
    @game.player_hand = hand1
    @game.dealer_hand = hand2
    assert @game.player_wins?
  end

  def test_player_loses_tie_with_fewer_cards
    hand1 = [Card.new("10", "Diamonds"), Card.new("Queen", "Diamonds")]
    hand2 = [Card.new("3", "Diamonds"), Card.new("Queen", "Diamonds"), Card.new("7", "Diamonds")]
    @game.player_hand = hand1
    @game.dealer_hand = hand2
    assert !@game.player_wins?
  end

  def test_player_wins_with_6_cards_with_no_bust_or_blackjack
    hand = [Card.new("2", "Diamonds")] * 6
    hand = [Card.new("5", "Diamonds"), Card.new("10", "Diamonds")]
    @game.player_hand = hand
    assert @game.player_wins?
  end

  def test_player_wins_if_value_of_hand_is_greater_than_dealer_hand
    hand1 = [Card.new("10", "Diamonds"), Card.new("Queen", "Diamonds")]
    hand2 = [Card.new("7", "Diamonds"), Card.new("Queen", "Diamonds")]
    @game.player_hand = hand1
    @game.dealer_hand = hand2
    assert @game.player_wins?
  end

  def test_player_wins_if_dealer_busts
    hand1 = [Card.new("10", "Diamonds"), Card.new("Queen", "Diamonds")]
    hand2 = [Card.new("7", "Diamonds"), Card.new("Queen", "Diamonds"), Card.new("7", "Diamonds")]
    @game.player_hand = hand1
    @game.dealer_hand = hand2
    assert @game.player_wins?
  end

end
