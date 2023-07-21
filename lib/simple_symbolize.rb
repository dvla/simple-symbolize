# frozen_string_literal: true

require 'simple_symbolize/version'

require_relative 'simple_symbolize/string'
require_relative 'simple_symbolize/translations'

include SimpleSymbolize

# Main module for the gem
# Contains the base methods and allows configuration
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
  def self.translate
    yield(translations) if block_given?
  end

  # Symbolizes a String object.
  #
  # @param obj [Object] the String object to be symbolized.
  #
  # @example Symbolize a string using the symbolize method
  #   symbolize("hello world!") #=> :hello_world
  def symbolize(obj)
    return obj unless obj.respond_to?(:to_s)
    return obj if [Hash, Array, NilClass].include?(obj.class)

    str = obj.to_s
    str = str.to_snake_case if SimpleSymbolize.translations.handle_camel_case

    str.downcase
       .gsub(Regexp.union(SimpleSymbolize.translations.underscore), '_')
       .gsub(Regexp.union(SimpleSymbolize.translations.remove), '')
       .to_sym
  end

  # Symbolizes a String object and returns it as a String object.
  #
  # @param obj [Object] the object to be symbolized.
  #
  # @example Elementize a string using the elementize method
  #   elementize("hello world!") #=> "helloWorld"
  def elementize(obj)
    return obj unless obj.respond_to?(:to_s)
    return obj if [Hash, Array, NilClass].include?(obj.class)

    symbolize(obj).to_s
  end

  # Turns a String object into a camelCase Symbol.
  #
  # @param obj [Object] the String object to be camelized.
  #
  # @example Camelize a string using the camelize method
  #   camelize("hello world!") #=> :helloWorld
  def camelize(obj)
    return obj unless obj.respond_to?(:to_s)
    return obj if [Hash, Array, NilClass].include?(obj.class)

    first, *rest = elementize(obj).split('_')
    return obj if first.nil?

    rest.size.positive? ? (first << rest.map(&:capitalize).join).to_sym : symbolize(first)
  end
end
