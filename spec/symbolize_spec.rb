RSpec.describe Symbolize do
  it "has a version number" do
    expect(Symbolize::VERSION).not_to be nil
  end

  it "extends String class" do
    expect("This is a test".symbolize).to eq(:this_is_a_test)
  end

  it "has a symbolize method" do
    expect(Symbolize.symbolize('This is a test')).to eq(:this_is_a_test)
  end

  it "has default translations" do
    expect(Symbolize.translations.underscore).to eq([' '])
    expect(Symbolize.translations.remove).to eq(['\'', '(', ')'])
  end

  it "can translate a block" do
    Symbolize.translate { |trans| trans.to_underscore('!@£$%^&') }
    expect(Symbolize.symbolize('T!h@i£s i$s% a^ t&est')).to eq(:t_h_i_s_i_s__a__t_est)

    Symbolize.translate { |trans| trans.to_remove('!@£$%^&') }
    expect(Symbolize.symbolize('T!h@i£s i$s% a^ t&est')).to eq(:this_is_a_test)

    Symbolize.translate do |trans|
      trans.to_underscore('!')
      trans.to_remove('&')
    end
    expect(Symbolize.symbolize('Hello&World!')).to eq(:helloworld_)
  end

  it "can handle duplicates when configuring" do
    Symbolize.translate do |trans|
      trans.to_underscore('!')
      trans.to_underscore('!')
    end
    expect(Symbolize.translations.underscore.count { |i| i.eql?('!') }).to eq(1)

    Symbolize.translate do |trans|
      trans.to_remove('!')
      trans.to_remove('!')
    end
    expect(Symbolize.translations.remove.count { |i| i.eql?('!') }).to eq(1)
  end

  it "will ensure the same character doesn't appear in both attributes" do
    Symbolize.translate do |trans|
      trans.to_underscore('!')
      trans.to_remove('!')
    end
    expect(Symbolize.translations.underscore.count { |i| i.eql?('!') }).to eq(0)
    expect(Symbolize.translations.remove.count { |i| i.eql?('!') }).to eq(1)

    Symbolize.translate do |trans|
      trans.to_remove('!')
      trans.to_underscore('!')
    end
    expect(Symbolize.translations.underscore.count { |i| i.eql?('!') }).to eq(1)
    expect(Symbolize.translations.remove.count { |i| i.eql?('!') }).to eq(0)
  end

  it "can handle non-strings in the translate block" do
    expect { Symbolize.translate { |trans| trans.to_underscore(['!@£$%^&']) } }.not_to raise_error
    expect { Symbolize.translate { |trans| trans.to_underscore({ a: :b }) } }.not_to raise_error
    expect { Symbolize.translate { |trans| trans.to_remove(['!@£$%^&']) } }.not_to raise_error
    expect { Symbolize.translate { |trans| trans.to_remove({ a: :b }) } }.not_to raise_error
  end
end
