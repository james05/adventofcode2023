class DocumentLine
  def initialize(line)
    @line = line
  end

  def calibration_value
    find_digits.values_at(0, -1).join.to_i
  end

  private
  def find_digits
    @line.scan(/\d/)
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