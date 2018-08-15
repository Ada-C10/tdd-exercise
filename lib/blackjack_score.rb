# blackjack_score.rb
require "pry"
VALID_CARDS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'King', 'Queen', 'Jack']

def blackjack_score(hand)
  # Raise ArgumentError for invalid cards
  if !hand.is_a?(Array)
    raise ArgumentError, "Hand must be an array"
  elsif hand.size > 3 || hand.size < 1
    raise ArgumentError, "Hand must be 1-3 cards"
  else
    hand.each do |card|
      if !VALID_CARDS.include?(card)
        raise ArgumentError, "Invalid card(s)"
      end
    end
  end
  # Generates parallel array for score, e.g. [10, 1, 3]
  scores_low_ace = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
  card_to_score_low_ace = Hash[VALID_CARDS.zip(scores_low_ace)] # {1=>1, 2=>2, 3=>3, 4=>4, 5=>5, 6=>6, 7=>7, 8=>8, 9=>9, "King"=>10, "Queen"=>10, "Jack"=>10}
  scores = []
  hand.size.times do |i|
    sum_before_this_card = scores.reduce(0, :+)
    # ace default score is 1
    # if card is an ace, score can be 11 in this case ONLY:
    if hand[i] == 1 && sum_before_this_card < 10
        scores << 11
    else
      # if card is not an ace
      card_score = card_to_score_low_ace[hand[i]]
      scores << card_score
    end
  end
  # Sum
  score = scores.reduce(:+)
  # raise ArgumentError for scores over 21
  if score > 21
    raise ArgumentError, "You lose! Score > 21"
  end
  # return score
  return score
end
