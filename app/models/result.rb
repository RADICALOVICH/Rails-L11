class Result < ApplicationRecord
  include SequenceHelper
  include ActiveModel::Serializers::Xml
  self.primary_key = 'sequence'

  attr_accessor :number, :string_array

  before_save :before_saving

  validates_presence_of :number, :string_array
  validates :number, format: { with: /\d/, message: 'должно быть числом' }
  validates :string_array, format: { without: /[^\d^\s^]/, message: 'ошибка при вводе строки' }
  validate :valid_length?

  def before_saving
    self.n = number.to_i
    self.sequence = string_of_input_sequence
    self.result_sequences = json_result_sequences
    self.max_sequence = find_max_sequence
  end

  def valid_length?
    errors.add(:number, 'is not correct') if string_array&.split&.map(&:to_i)&.length != number.to_i
  end
end
