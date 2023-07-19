# frozen_string_literal: true

RSpec.describe String do
  it 'has a symbolize method' do
    String.respond_to?(:symbolize)
  end

  it 'has a to_snake_case method' do
    String.respond_to?(:to_snake_case)
  end

  context 'symbolize method' do
    it 'symbolizes the String' do
      expect('This is quite a test'.symbolize).to eq(:this_is_quite_a_test)
    end
  end

  context 'to_snake_case method' do
    it 'returns the String as snake_case' do
      expect('ThisIsQuiteATest'.to_snake_case).to eq('this_is_quite_a_test')
    end
  end
end
