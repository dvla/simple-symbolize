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

    attr_reader :handle_camel_case

    # Creates an instance of the Translations class.
    #
    # Sets the class variables to a default state.
    def initialize
      reset!
    end

    # Merges the String passed with the @underscore Array omitting duplicates.
    # Removes those characters from the @remove and @omit Arrays to avoid the change being over-written.
    #
    # @param chars [Array] an object containing characters to be underscored.
    #
    # @return [Array] the Array of characters to be underscored.
    def to_underscore=(chars)
      chars = sanitise_chars(chars)

      @remove -= chars
      @omit -= chars
      @underscore |= chars
    end

    # Merges the String passed with the @remove Array omitting duplicates.
    # Removes those characters from the @underscore and @omit Arrays to avoid the change being over-written.
    #
    # @param chars [String] a String object containing characters to be removed.
    #
    # @return [Array] the Array of characters to be removed.
    def to_remove=(chars)
      chars = sanitise_chars(chars)

      @underscore -= chars
      @omit -= chars
      @remove |= chars
    end

    # Removes characters within the String passed from the @remove and @underscore Arrays.
    #
    # @param chars [String] a String object containing characters to be removed.
    #
    # @return [Array] the Array of characters to be omitted.
    def to_omit=(chars)
      chars = sanitise_chars(chars)

      @underscore -= chars
      @remove -= chars
      @omit += chars
    end

    def handle_camel_case=(handle)
      handle = handle.to_s.downcase
      raise ArgumentError 'needs to be either `true` or `false`' unless %w[true false].include?(handle)

      @handle_camel_case = handle.eql?('true')
    end

    def reset!
      @underscore = [' ']
      @remove = %w[\' ( ) , . : " ! @ £ $ % ^ & *]
      @omit = []
      @handle_camel_case = true
    end

    private

    # Converts chars into Array of Strings
    #
    # @param arg Arg to be converted
    #
    # @return Array of Strings
    #
    # @raise [ArgumentError] if the arg is not either a String or an Array.
    def sanitise_chars(arg)
      raise ArgumentError 'needs to be a String or an Array of characters' unless [String, Array].include?(arg.class)

      arg.respond_to?(:chars) ? arg.chars : arg.map(&:to_s)
    end
  end
end
