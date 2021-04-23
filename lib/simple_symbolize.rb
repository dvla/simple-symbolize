require 'simple_symbolize/version'

require_relative 'simple_symbolize/string.rb'
require_relative 'simple_symbolize/translations.rb'

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
  def self.symbolize(str)
    return str if str.is_a?(Symbol) || str.nil?
    str.downcase.tr(translations.underscore.join, '_')&.tr(translations.remove.join, '')&.to_sym
  end
end
