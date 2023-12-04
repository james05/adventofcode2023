
class Card
  def initialize(input)
    winning, you = input.split('|')

    card_number, winning = winning.split(':')

    @winning = winning.lstrip.split(/\s+/)

    @you = you.lstrip.split(/\s+/)
  end

  def compute_points
    winning_numbers_you_hold = (@you & @winning).count

    return 0 if winning_numbers_you_hold == 0
    2 ** (winning_numbers_you_hold - 1)
  end
end

total_points = ARGF.sum do |game|
  card = Card.new(game)

  card.compute_points
end

puts total_points