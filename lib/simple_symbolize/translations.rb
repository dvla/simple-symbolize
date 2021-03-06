module SimpleSymbolize
  # The translations class holds the attributes used to transform a String object.
  # It also provides helper methods to manipulate those attributes.
  class Translations
    # @return [Array] the characters to be transformed into underscores.
    attr_accessor :underscore
    # @return [Array] the characters to be removed from the String.
    attr_accessor :remove
    # @return [Array] the characters to be untouched from the String.
    attr_accessor :omit

    # Creates an instance of the Translations class.
    #
    # Sets the class variables to a default state.
    def initialize
      @underscore = [' ']
      @remove = %w[\' ( ) , . : "]
      @omit = []
    end

    # Merges the String passed with the @underscore Array omitting duplicates.
    # Removes those characters from the @remove ans @omit Arrays to avoid the change being over-written.
    #
    # @param t [String] a String object containing characters to be underscored.
    #
    # @return [Array] the Array of characters to be underscored.
    #
    # @raise [ArgumentError] if the param does not respond to  #to_s.
    def to_underscore(t)
      raise ArgumentError 'needs to be a String or respond to #to_s' unless t.respond_to?(:to_s)

      @remove -= t.to_s.chars
      @omit -= t.to_s.chars
      @underscore |= t.to_s.chars
    end

    # Merges the String passed with the @remove Array omitting duplicates.
    # Removes those characters from the @underscore and @omit Arrays to avoid the change being over-written.
    #
    # @param t [String] a String object containing characters to be removed.
    #
    # @return [Array] the Array of characters to be removed.
    #
    # @raise [ArgumentError] if the param does not respond to  #to_s.
    def to_remove(t)
      raise ArgumentError 'needs to be a String or respond to #to_s' unless t.respond_to?(:to_s)

      @underscore -= t.to_s.chars
      @omit -= t.to_s.chars
      @remove |= t.to_s.chars
    end

    # Removes characters within the String passed from the @remove and @underscore Arrays.
    #
    # @param t [String] a String object containing characters to be removed.
    #
    # @return [Array] the Array of characters to be omitted.
    #
    # @raise [ArgumentError] if the param does not respond to  #to_s.
    def to_omit(t)
      raise ArgumentError 'needs to be a String or respond to #to_s' unless t.respond_to?(:to_s)

      @underscore -= t.to_s.chars
      @remove -= t.to_s.chars
      @omit += t.to_s.chars
    end
  end
end
