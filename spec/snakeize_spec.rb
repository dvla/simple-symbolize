# frozen_string_literal: true

RSpec.describe SimpleSymbolize do
  it 'has an snakeize method' do
    expect(SimpleSymbolize.snakeize('This is a test')).to eq(:this_is_a_test)
    expect(SimpleSymbolize.snakeize('thisIsATest')).to eq(:this_is_a_test)
    expect(SimpleSymbolize.snakeize('THISIsATest')).to eq(:this_is_a_test)
    expect(SimpleSymbolize.snakeize('this_is_a_test')).to eq(:this_is_a_test)
    expect(SimpleSymbolize.snakeize('This is a test!')).to eq(:this_is_a_test)
  end

  it 'can handle non String parameters in the snakeize method' do
    expect(SimpleSymbolize.snakeize(nil)).to eq(nil)
    expect(SimpleSymbolize.snakeize({})).to eq({})
    expect(SimpleSymbolize.snakeize([])).to eq([])
    expect(SimpleSymbolize.snakeize('')).to eq('')
  end

  context 'strip_chars option' do
    it 'strips chars by default' do
      expect(SimpleSymbolize.snakeize('Hello World!')).to eq(:hello_world)
    end

    it 'does not strip chars when strip_chars is false' do
      expect(SimpleSymbolize.snakeize('Hello World!', strip_chars: false)).to eq(:hello_world!)
    end

    it 'continues to strip chars when strip_chars is true' do
      expect(SimpleSymbolize.snakeize('Hello World!', strip_chars: true)).to eq(:hello_world)
    end

    it 'does not strip chars when strip_chars is not a boolean' do
      expect(SimpleSymbolize.snakeize('Hello World!', strip_chars: 'not_a_boolean')).to eq(:hello_world!)
    end
  end
end
