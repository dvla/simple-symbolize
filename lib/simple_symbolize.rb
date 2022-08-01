require 'simple_symbolize/version'

require_relative 'simple_symbolize/string'
require_relative 'simple_symbolize/translations'

include SimpleSymbolize

module SimpleSymbolize
  class Error < StandardError; end

  # Returns the translations object, initializing it if necessary.
  #
  # @return [Translations] the translations object.
  def self.translations
    @translations ||= Translations.new
  end

  # Configures the Symbolize environment.
  #
  # @yieldparam [Translations] config the translations object yielded to the block.
  def self.translate(&block)
    yield translations
  end

  # Symbolizes a String object.
  #
  # @param str [String] the String object to be symbolized.
  #
  # @example Symbolize a string using the symbolize method
  #   symbolize("hello world!") #=> :hello_world
  def symbolize(str)
    return str if str.is_a?(Symbol) || str.nil?

    str.downcase.tr(SimpleSymbolize.translations.underscore.join, '_')
      &.tr(SimpleSymbolize.translations.remove.join, '')&.to_sym
  end

  # Symbolizes a String object and returns it as a String object.
  #
  # @param str [String] the String object to be symbolized.
  #
  # @example Elementize a string using the elementize method
  #   elementize("hello world!") #=> "helloWorld"
  def elementize(str)
    return str unless str.is_a?(Symbol) || str.is_a?(String)

    symbolize(str).to_s
  end

  # Turns a String object into a camelCase Symbol.
  #
  # @param str [String] the String object to be camelized.
  #
  # @example Camelize a string using the camelize method
  #   camelize("hello world!") #=> :helloWorld
  def camelize(str)
    return str unless str.is_a?(String) || str.is_a?(Symbol)
    return symbolize(str) if str.is_a?(String) && (str.split(/[_ ]/).size <= 1)

    first, *rest = elementize(str).split('_')
    rest ? (first << rest.map(&:capitalize).join).to_sym : symbolize(first)
  end
end
