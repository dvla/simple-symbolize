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
end
