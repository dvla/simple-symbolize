RSpec.describe SimpleSymbolize do
  it 'has an camelize method' do
    expect(SimpleSymbolize.camelize('This is a test')).to eq(:thisIsATest)
    expect(SimpleSymbolize.camelize('This, is a test')).to eq(:thisIsATest)
    expect(SimpleSymbolize.camelize('This_is_a_test')).to eq(:thisIsATest)
    expect(SimpleSymbolize.camelize('thisIsATest')).to eq(:thisIsATest)
    expect(SimpleSymbolize.camelize('test')).to eq(:test)
    expect(SimpleSymbolize.camelize(:thisIsATest)).to eq(:thisIsATest)
    expect(SimpleSymbolize.camelize(:this_is_a_test)).to eq(:thisIsATest)
    expect(SimpleSymbolize.camelize(:test)).to eq(:test)
  end

  it 'can handle non String parameters in the camelize method' do
    expect(SimpleSymbolize.camelize(nil)).to eq(nil)
    expect(SimpleSymbolize.camelize({ })).to eq({ })
    expect(SimpleSymbolize.camelize([])).to eq([])
    expect(SimpleSymbolize.camelize('')).to eq(:'')
  end
end