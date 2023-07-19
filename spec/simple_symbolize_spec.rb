# frozen_string_literal: true

RSpec.describe SimpleSymbolize do
  after(:each) do
    SimpleSymbolize.translations.reset!
  end

  it 'has a version number' do
    expect(SimpleSymbolize::VERSION).not_to be nil
  end

  it 'extends String class' do
    expect('This is a test'.symbolize).to eq(:this_is_a_test)
  end

  it 'has a symbolize method' do
    expect(SimpleSymbolize.symbolize('This is a test')).to eq(:this_is_a_test)
  end

  it 'will handle TrueClass, FalseClass and Integers' do
    expect(SimpleSymbolize.symbolize(true)).to eq(true)
    expect(SimpleSymbolize.symbolize(false)).to eq(false)
    expect(SimpleSymbolize.symbolize(1)).to eq(1)
  end

  it 'can call #symbolize without the namespace' do
    expect(symbolize('Hello World!')).to eq(:hello_world)
  end

  it 'can omit characters from transformation' do
    SimpleSymbolize.translate { |trans| trans.to_remove = '!' }
    expect('Hello World!'.symbolize).to eq(:hello_world)

    SimpleSymbolize.translate { |trans| trans.to_omit = '!' }
    expect('Hello World!'.symbolize).to eq(:hello_world!)
  end

  it 'can handle camelCaseStrings by default' do
    expect(SimpleSymbolize.symbolize('thisIsATest')).to eq(:this_is_a_test)
  end

  it 'can ignore camelCaseStrings' do
    SimpleSymbolize.translate { |trans| trans.handle_camel_case = false }

    expect(SimpleSymbolize.symbolize('thisIsATest')).to eq(:thisisatest)
  end

  it 'has consistent behaviour between methods' do
    expect(symbolize(true)).to eq(true)
    expect(elementize(true)).to eq(true)
    expect(camelize(true)).to eq(true)

    expect(symbolize(nil)).to eq(nil)
    expect(elementize(nil)).to eq(nil)
    expect(camelize(nil)).to eq(nil)
  end

  context 'config' do
    it 'accepts Arrays' do
      SimpleSymbolize.translate do |trans|
        trans.to_underscore = %w[!]
        trans.to_remove = %w[@]
        trans.to_omit = %w[&]
      end

      expect(SimpleSymbolize.symbolize('This! is @ test&')).to eq(:'this__is__test&')
    end

    it 'accepts Strings' do
      SimpleSymbolize.translate do |trans|
        trans.to_underscore = '!'
        trans.to_remove = '@'
        trans.to_omit = '&'
      end

      expect(SimpleSymbolize.symbolize('This! is @ test&')).to eq(:'this__is__test&')
    end

    it 'has default translations' do
      expect(SimpleSymbolize.translations.underscore).to eq([' '])
      expect(SimpleSymbolize.translations.remove).to eq(%w[\' ( ) , . : " ! @ £ $ % ^ & *])
      expect(SimpleSymbolize.translations.omit).to eq(%w[])
    end

    it 'can translate a block' do
      SimpleSymbolize.translate { |trans| trans.to_underscore = '!@£$%^&' }
      expect(SimpleSymbolize.symbolize('T!h@i£s i$s% a^ t&est')).to eq(:t_h_i_s_i_s__a__t_est)

      SimpleSymbolize.translate { |trans| trans.to_remove = '!@£$%^&' }
      expect(SimpleSymbolize.symbolize('T!h@i£s i$s% a^ t&est')).to eq(:this_is_a_test)

      SimpleSymbolize.translate do |trans|
        trans.to_underscore = '!'
        trans.to_remove = '&'
      end
      expect(SimpleSymbolize.symbolize('Hello&World!')).to eq(:helloworld_)
    end

    it 'can handle duplicates' do
      SimpleSymbolize.translate do |trans|
        trans.to_underscore = '!'
        trans.to_underscore = '!'
      end
      expect(SimpleSymbolize.translations.underscore.count { |i| i.eql?('!') }).to eq(1)

      SimpleSymbolize.translate do |trans|
        trans.to_remove = '!'
        trans.to_remove = '!'
      end
      expect(SimpleSymbolize.translations.remove.count { |i| i.eql?('!') }).to eq(1)
    end

    it "will ensure the same character doesn't appear in both attributes" do
      SimpleSymbolize.translate do |trans|
        trans.to_underscore = '!'
        trans.to_remove = '!'
      end
      expect(SimpleSymbolize.translations.underscore.count { |i| i.eql?('!') }).to eq(0)
      expect(SimpleSymbolize.translations.remove.count { |i| i.eql?('!') }).to eq(1)

      SimpleSymbolize.translate do |trans|
        trans.to_remove = '!'
        trans.to_underscore = '!'
      end
      expect(SimpleSymbolize.translations.underscore.count { |i| i.eql?('!') }).to eq(1)
      expect(SimpleSymbolize.translations.remove.count { |i| i.eql?('!') }).to eq(0)
    end

    it 'can handle non-strings in the translate block' do
      expect { SimpleSymbolize.translate { |trans| trans.to_underscore = ['!@£$%^&'] } }.not_to raise_error
      expect { SimpleSymbolize.translate { |trans| trans.to_remove = ['!@£$%^&'] } }.not_to raise_error
    end

    it 'will return given characters to a translation block' do
      expect(
        SimpleSymbolize.translate do |trans|
          trans.to_omit = '^'
        end
      ).to include('^')

      expect(SimpleSymbolize.translations.underscore).not_to include('^')
      expect(SimpleSymbolize.translations.remove).not_to include('^')

      expect(
        SimpleSymbolize.translate do |trans|
          trans.to_underscore = '^'
        end
      ).to include('^')

      expect(SimpleSymbolize.translations.omit).not_to include('^')
      expect(SimpleSymbolize.translations.remove).not_to include('^')

      expect(
        SimpleSymbolize.translate do |trans|
          trans.to_remove = '^'
        end
      ).to include('^')

      expect(SimpleSymbolize.translations.omit).not_to include('^')
      expect(SimpleSymbolize.translations.underscore).not_to include('^')
    end
  end
end
