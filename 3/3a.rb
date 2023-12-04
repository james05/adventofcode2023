DX = [1, -1, 1, 1, -1, -1, 0, 0]
DY = [0, 0, 1, -1, 1, -1, 1, -1]


grid = []

ARGF.each { |line| grid << "#{line.strip}." }

sum = 0

def is_part_number?(grid, row_idx, col_idx)
  0.upto(7) do |i|
    newrow = row_idx + DX[i]
    newcol = col_idx + DY[i]

    next if newrow < 0 || newrow >= grid.length || newcol < 0 || newcol >= grid[row_idx].length

    char = grid[newrow][newcol]

    next if char =~ /\d/ || char == '.'
    return true
  end

  return false
end

class Digit
  def initialize
    @number = ''
    @is_part_number = false
  end

  def make_part_number
    @is_part_number = true
  end

  def <<(digit)
    @number << digit
  end

  def to_s
    @number
  end

  def is_part_number?
    @is_part_number
  end

  def number
    @number.to_i
  end
end

grid.each.with_index do |row, row_idx|
  digit = Digit.new
  puts row.inspect
  puts

  row.each_char.with_index do |char, col_idx|
    if char =~ /\d/
      digit << char
      if is_part_number?(grid, row_idx, col_idx)
        digit.make_part_number
      end
    else
      #puts "Digit: #{digit} Is part number: #{digit.is_part_number?}" if digit.to_s != ''
      if digit.is_part_number?
        sum += digit.number
      end

      digit = Digit.new
    end
  end

=begin
For each character c in a row,
  - if character is a digit
    add it to digit and call is_part_number? - if true, set the number to a part number
  - if character is not a digit
    if digit is a part_number, update the sum
    reset digit to Digit.new
=end
end

puts sum