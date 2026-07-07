# frozen_string_literal: true

RSpec.describe SimpleSymbolize do
  it 'has an camelize method' do
    expect(SimpleSymbolize.camelize('This is a test')).to eq(:thisIsATest)
    expect(SimpleSymbolize.camelize('This, is a test')).to eq(:thisIsATest)
    expect(SimpleSymbolize.camelize('This_is_a_test')).to eq(:thisIsATest)
    expect(SimpleSymbolize.camelize('thisIsATest')).to eq(:thisIsATest)
    expect(SimpleSymbolize.camelize('This')).to eq(:this)
    expect(SimpleSymbolize.camelize('test')).to eq(:test)
    expect(SimpleSymbolize.camelize(:thisIsATest)).to eq(:thisIsATest)
    expect(SimpleSymbolize.camelize(:this_is_a_test)).to eq(:thisIsATest)
    expect(SimpleSymbolize.camelize(:test)).to eq(:test)
  end

  it 'can handle non String parameters in the camelize method' do
    expect(SimpleSymbolize.camelize(nil)).to eq(nil)
    expect(SimpleSymbolize.camelize({})).to eq({})
    expect(SimpleSymbolize.camelize([])).to eq([])
    expect(SimpleSymbolize.camelize('')).to eq('')
  end

  it 'handles camel case acronyms' do
    expect(SimpleSymbolize.camelize('from gb')).to eq(:fromGb)

    SimpleSymbolize.translations.camel_case_acronyms = ['gb']
    expect(SimpleSymbolize.camelize('from gb')).to eq(:fromGB)
  end

  context 'strip_chars option' do
    it 'strips chars by default' do
      expect(SimpleSymbolize.camelize('Hello World!')).to eq(:helloWorld)
    end

    it 'does not strip chars when strip_chars is false' do
      expect(SimpleSymbolize.camelize('Hello World!', strip_chars: false)).to eq(:helloWorld!)
    end

    it 'continues to strip chars when strip_chars is true' do
      expect(SimpleSymbolize.camelize('Hello World!', strip_chars: true)).to eq(:helloWorld)
    end

    it 'does not strip chars when strip_chars is not a boolean' do
      expect(SimpleSymbolize.camelize('Hello World!', strip_chars: 'not_a_boolean')).to eq(:helloWorld!)
    end
  end
end
