# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Static content', type: :system do
  let(:number_value) { 5 }
  let(:string_array_value) { '10 36 49 50 70' }
  scenario 'correct result' do
    visit root_path

    fill_in :number, with: number_value
    fill_in :string_array, with: string_array_value

    find('#calculate-btn').click

    expect(find('#result-container')).to have_text('Количество последовательностей: 2')
    expect(find('#result-container')).to have_text('Самая длинная последовательность: 36 49')
  end

  scenario 'do not fill values in form and click submit button' do
    visit root_path

    find('#calculate-btn').click

    Result.new.errors.messages.each do |message|
      expect(find('#result-container')).to have_text(message)
    end
  end

  scenario 'invalid values in form' do
    visit root_path

    fill_in :number, with: number_value

    find('#calculate-btn').click

    Result.new.errors.messages.each do |message|
      expect(find('#result-container')).to have_text(message)
    end
  end
end
