=begin


Race is 7 seconds long

[0,1,2,3,4,5,6,7]

Smallest number x such that x*(7-x) > 9 => 7x-x^2 > 9 => -x^2 + 7x - 9 > 0 where x <= 7
and

Largest number x < 7, such that x*(7-x) > 9  => -x^2 + 7x - 9 > 0 where x <= 7


Example:

1 * (7-1) = 1*6 = 6

2 * (7-2) = 2*5 = 10

3 * (7-3) = 3 * 4 = 12

=end


def calculate_number_of_winning_approaches(time, record_distance)
  (0..time).map { |i| i*(time-i) }.count { |distance| distance > record_distance }
end

_, time = ARGF.readline.split(':')
time = time.split(/\s+/).reject(&:empty?).map(&:to_i)

_, distance = ARGF.readline.split(':')
distance = distance.split(/\s+/).reject(&:empty?).map(&:to_i)

total = time.each.with_index.reduce(1) do |acc, (race_time, index)|
  distance_to_beat = distance[index]

  number_of_ways_To_win = calculate_number_of_winning_approaches(race_time, distance_to_beat)

  acc * number_of_ways_To_win
end

puts total