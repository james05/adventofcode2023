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
  sets = game.split(';')
  
  min_colors = sets.reduce([-1, -1, -1]) do |acc, set|
    colors = parse_set(set)

    acc[0] = colors[0] if colors[0] > acc[0] && colors[0] > 0
    acc[1] = colors[1] if colors[1] > acc[1] && colors[1] > 0
    acc[2] = colors[2] if colors[2] > acc[2] && colors[2] > 0

    acc
  end
  
  {
    blue: min_colors[0],
    red: min_colors[1],
    green: min_colors[2]
  }

end



total = ARGF.sum do |game|
  min_valid_game = valid_game?(game)

  power = min_valid_game[:blue] * min_valid_game[:red] * min_valid_game[:green]
end

puts total