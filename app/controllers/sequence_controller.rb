# frozen_string_literal: true

# SequenceController
class SequenceController < ApplicationController
  include SequenceHelper
  def input; end

  def result
    @last = Result.order('created_at').last
    @last_array = ActiveSupport::JSON.decode(@last.result_sequences)
    @res = Result.new(sequence_params)
    Result.find_by_sequence(@res.string_of_input_sequence) ? find_object : create_object
  end

  def show_xml
    render xml: Result.all
  end

  private

  def sequence_params
    params.permit(:number, :string_array)
  end

  def find_object
    return unless @res.valid?

    @array = ActiveSupport::JSON.decode(Result.find_by_sequence(@res.string_of_input_sequence).result_sequences)
    @max_string = Result.find_by_sequence(@res.string_of_input_sequence).max_sequence&.split&.join(' ')
  end

  def create_object
    return unless @res.valid?

    @res.save
    @array = ActiveSupport::JSON.decode(@res.result_sequences)
    @max_string = @res.max_sequence&.split&.join(' ')
  end
end
