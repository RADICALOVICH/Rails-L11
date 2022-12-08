module SequenceHelper
  def squares(array)
    result_array = []
    array.each_with_index do |n, i|
      if  Math.sqrt(n).to_r.denominator == 1
        temp_array = array.slice(i, array.size - i)
        res = temp_array.take_while { |temp| Math.sqrt(temp).to_r.denominator == 1 }
        result_array.push(res)
      end
    end
    result_array
  end

  def string_of_input_sequence
    string_array.split.join(' ')
  end

  def result_sequence
    array = string_array.split.map(&:to_i)
    squares(array)
  end

  def find_max_sequence
    result_sequence.max_by(&:length)
  end

  def json_result_sequences
  result_sequence.map { |n| { "sequence": n } }.to_json
  end
end
