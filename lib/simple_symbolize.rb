# frozen_string_literal: true

require 'simple_symbolize/version'

require_relative 'simple_symbolize/translations'
require_relative 'simple_symbolize/core_ext/string/symbolize'

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
  #   SimpleSymbolize.symbolize("hello world!") #=> :hello_world
  def self.symbolize(obj)
    return obj unless obj.respond_to?(:to_s)
    return obj if [Hash, Array, NilClass].include?(obj.class)
    return obj if obj.respond_to?(:empty?) && obj.empty?

    obj = if SimpleSymbolize.translations.handle_camel_case
            snakeize(obj)
          else
            obj.to_s
               .downcase
               .gsub(Regexp.union(SimpleSymbolize.translations.underscore), '_')
               .gsub(Regexp.union(SimpleSymbolize.translations.remove), '')
          end
    obj.to_sym
  end

  # Symbolizes a String object and returns it as a String object.
  #
  # @param obj [Object] the object to be symbolized.
  #
  # @example Elementize a string using the elementize method
  #   SimpleSymbolize.elementize("hello world!") #=> "helloWorld"
  def self.elementize(obj)
    return obj unless obj.respond_to?(:to_s)
    return obj if [Hash, Array, NilClass].include?(obj.class)
    return obj if obj.respond_to?(:empty?) && obj.empty?

    symbolize(obj).to_s
  end

  # Turns a String object into a camelCase Symbol.
  #
  # @param obj [Object] the String object to be camelized.
  #
  # @example Camelize a string using the camelize method
  #   SimpleSymbolize.camelize("hello world!") #=> :helloWorld
  def self.camelize(obj)
    return obj unless obj.respond_to?(:to_s)
    return obj if [Hash, Array, NilClass].include?(obj.class)
    return obj if obj.respond_to?(:empty?) && obj.empty?

    first, *rest = elementize(obj).split('_')
    return obj if first.nil?

    rest.size.positive? ? (first << rest.map(&:capitalize).join).to_sym : symbolize(first)
  end

  # Turns a String || Symbol into a snake_case Symbol
  #
  # @param obj [Object] the object to be snakeize
  #
  # @example Snakeize an object using the snakeize method
  #   SimpleSymbolize.snakeize('Hello World!') #=> :hello_world
  def self.snakeize(obj)
    return obj unless obj.respond_to?(:to_s)
    return obj if [Hash, Array, NilClass].include?(obj.class)
    return obj if obj.respond_to?(:empty?) && obj.empty?

    obj.to_s
       .gsub(Regexp.union(SimpleSymbolize.translations.underscore), '_')
       .gsub(Regexp.union(SimpleSymbolize.translations.remove), '')
       .gsub(/([a-z\d])([A-Z])/, '\1_\2')
       .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
       .downcase
       .to_sym
  end
end
