#blackjack_score_spec.rb

require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
require "minitest/skip_dsl"

require_relative '../lib/blackjack_score'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe 'Blackjack Score' do
  it 'can calculate the score for a pair of number cards' do
    # Arrange
    hand = [6, 5]
    # Act
    score = blackjack_score(hand)
    # Assert <-  You do this part!
    expect(score).must_equal 11
  end

  it 'facecards have values calculated correctly' do
    face_cards = ["Jack", "Queen", "King"]
    face_cards.each do |card|
    # Arrange
      hand = Array.new
      2.times {hand.push(card)}
    # Act
      score = blackjack_score(hand)
    # Assert <-  You do this part!
      expect(score).must_equal 20
    end
  end

  it 'calculates aces as 11 where it does not go over 21' do
    # Arrange
    hand = [9,1]
    # Act
    score = blackjack_score(hand)
    # Assert <-  You do this part!
    expect(score).must_equal 20
  end

  it 'calculates aces as 1, if an 11 would cause the score to go over 21' do
    # Arrange
    hand = [10, 10, 1]
    # Act
    score = blackjack_score(hand)
    # Assert <-  You do this part!
    expect(score).must_equal 21

    # Arrange
    hand = [10,1]
    # Act
    score = blackjack_score(hand)
    # Assert <-  You do this part!
    expect(score).must_equal 11
  end

  it 'raises an ArgumentError for invalid cards' do
    # ARRANGE
    possible_hands = [[10,1],[6,5]]
    # Act-Assert
    possible_hands.each do |hand|
      score = blackjack_score(hand)
      expect(score).must_equal 11
    end
    # Re-arrange
    possible_hands = [[], nil, [0], ["Joker"], [1,2,3,4]]
    # Act-Assert
    possible_hands.each do |hand|
      expect{blackjack_score(hand)}.must_raise ArgumentError
    end
  end

  it 'raises an ArgumentError for scores over 21' do
    # ARRANGE
    hand = [10,10,2]
    # ACT-ASSERT
    expect{blackjack_score(hand)}.must_raise ArgumentError
  end
end
