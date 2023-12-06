
class Card
  def initialize(input)
    @card_number, cards = input.strip.split(':')
    @card_number = @card_number.gsub('Card ','')

    winning, you = cards.lstrip.split('|')

    @winning = winning.lstrip.split(/\s+/)

    @you = you.lstrip.split(/\s+/)
  end

  def matching_cards
    matching_cards = (@you & @winning).count

    matching_cards || 0
  end

  def card_number
    @card_number.to_i
  end
end

class Game
  attr_reader :total_cards

  def initialize
    @total_cards = 0
    # Key is "Game #" and value is list of all cards 
    @cards = {}
  end

  def add_card(card)
    @cards[card.card_number] ||= []

    @cards[card.card_number] << card

    @total_cards += 1
  end

  def process
    i = 1
    loop do
      break if @cards[i].nil?

      if @cards[i].empty?
        i = i + 1 # out of Card i
        next
      end
    
      card = @cards[i].first

      copy_winning_cards(card)
    end

  end

  private

  def copy_winning_cards(card)
    matching_cards = card.matching_cards

    1.upto(matching_cards) do |i|
      card_number_to_copy = card.card_number + i
      card_to_copy = @cards[card_number_to_copy].first
      break if card_to_copy.nil?

      add_card(card_to_copy)
    end

    @cards[card.card_number].shift


  end
end

game = Game.new

cards = {}

ARGF.each do |scratchcard|
  card = Card.new(scratchcard)
  game.add_card(card)
end

game.process

puts game.total_cards