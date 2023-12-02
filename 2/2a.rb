TOTAL_RED = 12
TOTAL_GREEN = 13
TOTAL_BLUE = 14

def valid_set?(set)
  blue, red, green = parse_set(set)

  red <= TOTAL_RED &&
  green <= TOTAL_GREEN &&
  blue <= TOTAL_BLUE
end


def parse_set(set)
  blue = (set.match(/(\d+) blue/) || [0,0])[1].to_i
  red = (set.match(/(\d+) red/) || [0,0])[1].to_i
  green = (set.match(/(\d+) green/) || [0,0])[1].to_i

  [blue, red, green]
end

def valid_game?(game)
  game.split(';').all? do |set|
    valid_set?(set) 
  end

end

def game_number(game)
  game.match(/Game (\d+):/)[1].to_i
end


total_ids = ARGF.sum do |game|
  valid_game?(game) ? game_number(game) : 0
end

puts total_ids