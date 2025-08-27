# frozen_string_literal: true

module SimpleSymbolize
  # The translations class holds the attributes used to transform a String object.
  # It also provides helper methods to manipulate those attributes.
  class Translations
    # @return [Array] the characters to be transformed into underscores.
    attr_reader :underscore
    # @return [Array] the characters to be removed from the String.
    attr_reader :remove
    # @return [Array] the characters to be untouched from the String.
    attr_reader :omit
    # @return [Boolean] whether to handle camelCase strings during symbolisation.
    attr_reader :handle_camel_case
    # @return [Array] the characters to be transformed into uppercase during camelisation.
    attr_reader :camel_case_acronyms

    # Creates an instance of the Translations class.
    #
    # Sets the class variables to a default state.
    def initialize
      reset!
    end

    # Merges the String passed with the @underscore Array omitting duplicates.
    # Removes those characters from @remove and @omit Arrays to avoid the change being over-written.
    #
    # @param input [Array] an object containing characters to be underscored.
    #
    # @return [Array] the Array of characters to be underscored.
    def to_underscore=(input)
      arr = sanitise(input)

      @remove -= arr
      @omit -= arr
      @underscore |= arr
    end

    # Merges the String passed with the @remove Array omitting duplicates.
    # Removes those characters from @underscore and @omit Arrays to avoid the change being over-written.
    #
    # @param input [String] a String object containing characters to be removed.
    #
    # @return [Array] the Array of characters to be removed.
    def to_remove=(input)
      arr = sanitise(input)

      @underscore -= arr
      @omit -= arr
      @remove |= arr
    end

    # Removes characters within the String passed from @remove and @underscore Arrays.
    #
    # @param input [String] a String object containing characters to be removed.
    #
    # @return [Array] the Array of characters to be omitted.
    def to_omit=(input)
      arr = sanitise(input)

      @underscore -= arr
      @remove -= arr
      @omit += arr
    end

    def handle_camel_case=(handle)
      handle = handle.to_s.downcase
      raise ArgumentError 'needs to be either `true` or `false`' unless %w[true false].include?(handle)

      @handle_camel_case = handle.eql?('true')
    end

    def camel_case_acronyms=(input)
      arr = sanitise(input)

      @camel_case_acronyms = arr.map { |word| word.is_a?(String) ? word.to_s.downcase : nil }.compact.uniq
    end

    def reset!
      @underscore = [' ', '::', '-']
      @remove = %w[' ( ) , . : " ! @ £ $ % ^ & * / { } [ ] < > ; = #]
      @omit = []
      @handle_camel_case = true
      @camel_case_acronyms = []
    end

    private

    # Sanitises the input into an Array of Strings
    #
    # @param input [String, Array] to be converted
    #
    # @return Array of Strings
    #
    # @raise [ArgumentError] if the arg is not either a String or an Array.
    def sanitise(input)
      raise ArgumentError 'needs to be a String or an Array' unless [String, Array].include?(input.class)

      if input.respond_to?(:chars)
        input.chars
      else
        input.map { |obj| obj.respond_to?(:to_s) ? obj.to_s.downcase : nil }.compact.uniq
      end
    end
  end
end
