class DocumentLine
  DIGITS = {
    'one' => '1',
    'two' => '2',
    'three' => '3',
    'four' => '4',
    'five' => '5',
    'six' => '6',
    'seven' => '7',
    'eight' => '8',
    'nine' => '9'
  }.freeze

  def initialize(line)
    @line = line
  end

  def calibration_value
    find_digits.to_i
  end

  private
  def find_digits
    numbers = []

    0.upto(@line.length-1) do |i|
      substring = @line[i..-1]

      digit = find_digit(substring)

      numbers << digit if digit != ''
    end

    first_digit = numbers.first
    last_digit = numbers.last

    "#{first_digit}#{last_digit}"
  end

  def find_digit(substring)
    DIGITS.each_pair do |word, number|
      if substring.start_with?(word)
        return number
      end

      if substring.start_with?(number)
        return number
      end
    end

    return ''
  end

end

class CalibrationDocument
  attr_reader :calibration_sum

  def initialize(input)
    @calibration_sum = input.sum do |line|
      DocumentLine.new(line).calibration_value
    end
  end
end

document = CalibrationDocument.new(ARGF)

puts document.calibration_sum

# puts DocumentLine.new('x8b').send(:find_first_digit) == '8'
# puts DocumentLine.new('2911threeninesdvxvheightwobm').send(:find_first_digit) == '2'
# puts DocumentLine.new('lsx3qrmznjrfnvvzveight5one').send(:find_first_digit) == '3'
# puts DocumentLine.new('eighthree').send(:find_first_digit) == '8'

# puts DocumentLine.new('x8b').send(:find_last_digit) == '8'
# puts DocumentLine.new('2911threeninesdvxvheightwobm').send(:find_last_digit) == '8'
# puts DocumentLine.new('lsx3qrmznjrfnvvzveight5one').send(:find_last_digit) == '1'
