class Card

  def self.suits
    %w(Clubs Spades Hearts Diamonds)
  end

  def self.faces
    %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
  end

  def self.face_cards
    face_card_array = {
                        "Jack"  => 10,
                        "Queen" => 10,
                        "King" => 10,
                        "Ace" => 11
                      }
  end

  attr_accessor :face, :suit, :value

  def initialize(face, suit)
    @face = face
    @suit = suit
    @value = assign_value
  end

  def assign_value
    if face.to_i.to_s == face
      self.class.faces.index(face) + 2
    else
      self.class.face_cards[face]
    end
  end

end
