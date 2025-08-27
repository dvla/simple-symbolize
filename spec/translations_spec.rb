# frozen_string_literal: true

RSpec.describe SimpleSymbolize::Translations do
  let(:default_underscore) { [' ', '::', '-'] }
  let(:default_remove) { %w[' ( ) , . : " ! @ £ $ % ^ & * / { } [ ] < > ; = #] }
  let(:default_omit) { [] }
  let(:default_handle_camel_case) { true }
  let(:default_acronyms) { [] }

  describe('#new') do
    it 'has default strings to underscore' do
      expect(subject.underscore).to eq(default_underscore)
    end

    it 'has default strings to remove' do
      expect(subject.remove).to eq(default_remove)
    end

    it 'omits nothing by default' do
      expect(subject.omit).to eq(default_omit)
    end

    it 'sets handle_camel_case to true by default' do
      expect(subject.handle_camel_case).to be(default_handle_camel_case)
    end

    it 'has no acronyms to uppercase by default' do
      expect(subject.camel_case_acronyms).to eq(default_acronyms)
    end
  end

  describe('#reset!') do
    before do
      subject.to_omit = ['abc']
      expect(subject.omit).to include('abc')

      subject.to_remove = ['def']
      expect(subject.remove).to include('def')

      subject.to_underscore = ['ghi']
      expect(subject.underscore).to include('ghi')

      subject.camel_case_acronyms = ['jkl']
      expect(subject.camel_case_acronyms).to include('jkl')

      subject.handle_camel_case = false
    end

    it 'resets attributes back to their default values' do
      subject.reset!

      expect(subject).to have_attributes(underscore: default_underscore,
                                         omit: default_omit,
                                         remove: default_remove,
                                         camel_case_acronyms: default_acronyms,
                                         handle_camel_case: default_handle_camel_case)
    end
  end

  describe('#to_underscore') do
    context('arg as string') do
      it('adds each char individually') do
        subject.to_underscore = 'abc'
        %w[a b c].each { |char| expect(subject.underscore).to include(char) }
      end
    end

    context('arg as array') do
      it('adds each array object') do
        to_underscore = %w[abc def]
        subject.to_underscore = to_underscore

        to_underscore.each { |char| expect(subject.underscore).to include(char) }
      end
    end
  end

  describe('#to_remove') do
    context('arg as string') do
      it('adds each char individually') do
        subject.to_remove = 'abc'
        %w[a b c].each { |char| expect(subject.remove).to include(char) }
      end
    end

    context('arg as array') do
      it('adds each array object') do
        to_remove = %w[abc def]
        subject.to_remove = to_remove

        to_remove.each { |char| expect(subject.remove).to include(char) }
      end
    end
  end

  describe('#to_omit') do
    context('arg as string') do
      it('adds each char individually') do
        subject.to_omit = 'abc'
        %w[a b c].each { |char| expect(subject.omit).to include(char) }
      end
    end

    context('arg as array') do
      it('adds each array object') do
        to_omit = %w[abc def]
        subject.to_omit = to_omit

        to_omit.each { |char| expect(subject.omit).to include(char) }
      end
    end
  end

  describe('#camel_case_acronyms') do
    context('arg as string') do
      it('adds each char individually') do
        subject.camel_case_acronyms = 'abc'
        %w[a b c].each { |char| expect(subject.camel_case_acronyms).to include(char) }
      end
    end

    context('arg as array') do
      it('adds each array object') do
        camel_case_acronyms = %w[abc def]
        subject.camel_case_acronyms = camel_case_acronyms

        camel_case_acronyms.each { |char| expect(subject.camel_case_acronyms).to include(char) }
      end
    end
  end

  context('contradiction') do
    it('ensures no duplication between attributes') do
      subject.to_underscore = 'a'
      expect(subject.underscore).to include('a')
      expect(subject.remove).not_to include('a')
      expect(subject.omit).not_to include('a')

      subject.to_remove = 'a'
      expect(subject.remove).to include('a')
      expect(subject.underscore).not_to include('a')
      expect(subject.omit).not_to include('a')

      subject.to_omit = 'a'
      expect(subject.omit).to include('a')
      expect(subject.underscore).not_to include('a')
      expect(subject.remove).not_to include('a')
    end
  end
end
