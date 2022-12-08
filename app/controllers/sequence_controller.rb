class SequenceController < ApplicationController
  include SequenceHelper
  def input; end

  def result
    @ok1 = true
    @ok2 = true
    @last = Result.order('created_at').last
    @last_array = ActiveSupport::JSON.decode(@last.result_sequences)
    @last_max_string = @last.max_sequence&.split&.join(' ')
    @res = Result.new(sequence_params)
    if @res.valid?
      if Result.find_by_sequence(@res.string_of_input_sequence)
        @array = ActiveSupport::JSON.decode(Result.find_by_sequence(@res.string_of_input_sequence).result_sequences)
        @max_string = Result.find_by_sequence(@res.string_of_input_sequence).max_sequence&.split&.join(' ')
      else
        @res.save
        @array = ActiveSupport::JSON.decode(@res.result_sequences)
        @max_string = @res.max_sequence&.split&.join(' ')
      end
    end
    @ok1 = false if @array == []
    @ok2 = false if @last_array == []
  end

  def show_xml
    render xml: Result.all
  end

  private

   def sequence_params
     params.permit(:number, :string_array)
   end
end
