require 'rails_helper'

RSpec.describe Result, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:number).with_message("can't be blank") }
    it { should validate_presence_of(:string_array).with_message("can't be blank") }

    context 'when number is not digits' do
      it { should_not allow_value(Faker::Lorem.word).for(:number) }
    end

    context 'when string is invalid' do
      it { should_not allow_value(Faker::Lorem.word).for(:string_array) }
    end
  end

  describe '#result' do
    let(:number_param) { 4 }
    let(:string_array_param) { '16 25 36 49' }
    let(:params) { { number: number_param, string_array: string_array_param } }

    subject { described_class.new(params) }

    it 'should return correct array' do
      expect(subject.result_sequence).to eq([[16, 25, 36, 49], [25, 36, 49], [36, 49], [49]])
      expect(subject.find_max_sequence).to eq([16, 25, 36, 49])
    end
  end

  describe 'checking database' do
    context 'adding to database' do
      let(:number_param) { 4 }
      let(:string_array_param) { '1 81 3 4' }
      let(:params) { { number: number_param, string_array: string_array_param } }
      it 'added to db' do
        expect(Result.where(sequence: '1 81 3 4').count).to eq(0)
        Result.create(params)
        expect(Result.where(sequence: '1 81 3 4').count).to eq(1)
        Result.find_by_sequence('1 81 3 4').delete
      end
    end
  end
end
