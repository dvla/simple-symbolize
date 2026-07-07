# frozen_string_literal: true

RSpec.describe SimpleSymbolize do
  it 'has an elementize method' do
    expect(SimpleSymbolize.elementize('This is a test')).to eq('this_is_a_test')
    expect(SimpleSymbolize.elementize(:This_is_a_test)).to eq('this_is_a_test')
    expect(SimpleSymbolize.elementize(:This)).to eq('this')
  end

  it 'can handle non String parameters in the elementize method' do
    expect(SimpleSymbolize.elementize(:this_is_a_test)).to eq('this_is_a_test')
    expect(SimpleSymbolize.elementize(nil)).to eq(nil)
    expect(SimpleSymbolize.elementize({})).to eq({})
    expect(SimpleSymbolize.elementize([])).to eq([])
    expect(SimpleSymbolize.elementize('')).to eq('')
  end

  context 'strip_chars option' do
    it 'strips chars by default' do
      expect(SimpleSymbolize.elementize('Hello World!')).to eq('hello_world')
    end

    it 'does not strip chars when strip_chars is false' do
      expect(SimpleSymbolize.elementize('Hello World!', strip_chars: false)).to eq('hello_world!')
    end

    it 'continues to strip chars when strip_chars is true' do
      expect(SimpleSymbolize.elementize('Hello World!', strip_chars: true)).to eq('hello_world')
    end

    it 'does not strip chars when strip_chars is not a boolean' do
      expect(SimpleSymbolize.elementize('Hello World!', strip_chars: 'not_a_boolean')).to eq('hello_world!')
    end
  end
end
