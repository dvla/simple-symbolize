RSpec.describe SimpleSymbolize do
  it "has a version number" do
    expect(SimpleSymbolize::VERSION).not_to be nil
  end

  it "extends String class" do
    expect("This is a test".symbolize).to eq(:this_is_a_test)
  end

  it "has a symbolize method" do
    expect(SimpleSymbolize.symbolize('This is a test')).to eq(:this_is_a_test)
  end

  it "has default translations" do
    expect(SimpleSymbolize.translations.underscore).to eq([' '])
    expect(SimpleSymbolize.translations.remove).to eq(%w[\' ( ) , . : "])
  end

  it "can translate a block" do
    SimpleSymbolize.translate { |trans| trans.to_underscore('!@£$%^&') }
    expect(SimpleSymbolize.symbolize('T!h@i£s i$s% a^ t&est')).to eq(:t_h_i_s_i_s__a__t_est)

    SimpleSymbolize.translate { |trans| trans.to_remove('!@£$%^&') }
    expect(SimpleSymbolize.symbolize('T!h@i£s i$s% a^ t&est')).to eq(:this_is_a_test)

    SimpleSymbolize.translate do |trans|
      trans.to_underscore('!')
      trans.to_remove('&')
    end
    expect(SimpleSymbolize.symbolize('Hello&World!')).to eq(:helloworld_)
  end

  it "can handle duplicates when configuring" do
    SimpleSymbolize.translate do |trans|
      trans.to_underscore('!')
      trans.to_underscore('!')
    end
    expect(SimpleSymbolize.translations.underscore.count { |i| i.eql?('!') }).to eq(1)

    SimpleSymbolize.translate do |trans|
      trans.to_remove('!')
      trans.to_remove('!')
    end
    expect(SimpleSymbolize.translations.remove.count { |i| i.eql?('!') }).to eq(1)
  end

  it "will ensure the same character doesn't appear in both attributes" do
    SimpleSymbolize.translate do |trans|
      trans.to_underscore('!')
      trans.to_remove('!')
    end
    expect(SimpleSymbolize.translations.underscore.count { |i| i.eql?('!') }).to eq(0)
    expect(SimpleSymbolize.translations.remove.count { |i| i.eql?('!') }).to eq(1)

    SimpleSymbolize.translate do |trans|
      trans.to_remove('!')
      trans.to_underscore('!')
    end
    expect(SimpleSymbolize.translations.underscore.count { |i| i.eql?('!') }).to eq(1)
    expect(SimpleSymbolize.translations.remove.count { |i| i.eql?('!') }).to eq(0)
  end

  it "can handle non-strings in the translate block" do
    expect { SimpleSymbolize.translate { |trans| trans.to_underscore(['!@£$%^&']) } }.not_to raise_error
    expect { SimpleSymbolize.translate { |trans| trans.to_underscore({ a: :b }) } }.not_to raise_error
    expect { SimpleSymbolize.translate { |trans| trans.to_remove(['!@£$%^&']) } }.not_to raise_error
    expect { SimpleSymbolize.translate { |trans| trans.to_remove({ a: :b }) } }.not_to raise_error
  end

  it "can call #symbolize without the namespace" do
    expect(symbolize('Hello World!')).to eq(:hello_world)
  end

  it "can omit characters from transformation" do
    SimpleSymbolize.translate { |trans| trans.to_remove('!') }
    expect('Hello World!'.symbolize).to eq(:hello_world)

    SimpleSymbolize.translate { | trans | trans.to_omit('!') }
    expect('Hello World!'.symbolize).to eq(:hello_world!)
  end

  it "will return given characters to a translation block" do
    expect(
      SimpleSymbolize.translate do |trans|
        trans.to_omit('^')
      end
    ).to include('^')

    expect(SimpleSymbolize.translations.underscore).not_to include('^')
    expect(SimpleSymbolize.translations.remove).not_to include('^')

    expect(
      SimpleSymbolize.translate do |trans|
        trans.to_underscore('^')
      end
    ).to include('^')

    expect(SimpleSymbolize.translations.omit).not_to include('^')
    expect(SimpleSymbolize.translations.remove).not_to include('^')

    expect(
      SimpleSymbolize.translate do |trans|
        trans.to_remove('^')
      end
    ).to include('^')

    expect(SimpleSymbolize.translations.omit).not_to include('^')
    expect(SimpleSymbolize.translations.underscore).not_to include('^')
  end
end
