module GameLogic

  def blackjack?(hand)
    total_hand(hand) == 21
  end

  def bust?(hand)
    total_hand(hand) > 21
  end

  def check_for_ace(hand)
    ace = hand.detect { |card| card.face == "Ace" }
    ace&.value = 1
  end

  def end_dealer_turn
    blackjack?(player_hand) ||
    bust?(player_hand) ||
    bust?(dealer_hand) ||
    blackjack?(dealer_hand) ||
    total_hand(dealer_hand) > 15
  end

  def end_player_turn
    blackjack?(dealer_hand) || bust?(player_hand) || blackjack?(player_hand)
  end

  def player_has_6_cards?
    player_hand.length > 5 && total_hand(player_hand) < 21
  end

  def player_wins?
    !bust?(player_hand) && not_simultaneous_blackjack &&(
    blackjack?(player_hand) ||
    player_wins_tie? ||
    player_has_6_cards? ||
    total_hand(player_hand) > total_hand(dealer_hand) ||
    bust?(dealer_hand)
    )
  end

  def not_simultaneous_blackjack
    !(player_hand.length == 2 &&
    dealer_hand.length == 2 &&
    blackjack?(player_hand) &&
    blackjack?(dealer_hand))
  end

  def player_wins_tie?
    total_hand(player_hand) == total_hand(dealer_hand) && player_hand.length >= dealer_hand.length
  end

  def total_hand(hand)
    hand.inject(0) { |sum, card| sum += card.value }
  end

end
