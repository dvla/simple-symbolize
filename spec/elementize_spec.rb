# frozen_string_literal: true

RSpec.describe SimpleSymbolize do
  it 'has an elementize method' do
    expect(SimpleSymbolize.elementize('This is a test')).to eq('this_is_a_test')
    expect(SimpleSymbolize.elementize(:This_is_a_test)).to eq('This_is_a_test')
    expect(SimpleSymbolize.elementize(:This)).to eq('This')
  end

  it 'can handle non String parameters in the elementize method' do
    expect(SimpleSymbolize.elementize(:this_is_a_test)).to eq('this_is_a_test')
    expect(SimpleSymbolize.elementize(nil)).to eq(nil)
    expect(SimpleSymbolize.elementize({})).to eq({})
    expect(SimpleSymbolize.elementize([])).to eq([])
    expect(SimpleSymbolize.elementize('')).to eq('')
  end
end
