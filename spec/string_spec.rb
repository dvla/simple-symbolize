# frozen_string_literal: true

RSpec.describe String do
  context 'simple_symbolize method' do
    it 'has a simple_symbolize method' do
      String.respond_to?(:simple_symbolize)
    end

    it 'symbolizes the String' do
      expect('This is quite a test'.simple_symbolize).to eq(:this_is_quite_a_test)
    end
  end

  context 'simple_snakeize method' do
    it 'has a to_snake_case method' do
      String.respond_to?(:simple_snakeize)
    end

    it 'returns a snake_case Symbol' do
      expect('ThisIsQuiteATest'.simple_snakeize).to eq(:this_is_quite_a_test)
    end
  end

  context 'simple_elementize method' do
    it 'has a simple_elementize method' do
      String.respond_to?(:simple_elementize)
    end

    it 'elementizes the String' do
      expect('This is quite a test'.simple_elementize).to eq('this_is_quite_a_test')
    end
  end

  context 'simple_camelize method' do
    it 'has a to_snake_case method' do
      String.respond_to?(:simple_camelize)
    end

    it 'returns a snake_case Symbol' do
      expect('ThisIsQuiteATest'.simple_camelize).to eq(:thisIsQuiteATest)
    end
  end
end
