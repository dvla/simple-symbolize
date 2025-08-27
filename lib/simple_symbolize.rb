# frozen_string_literal: true

require 'simple_symbolize/version'

require_relative 'simple_symbolize/translations'
require_relative 'simple_symbolize/core_ext/string/symbolize'
require_relative 'simple_symbolize/core_ext/symbol/symbolize'

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
    return obj unless valid_input?(obj)

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
    return obj unless valid_input?(obj)

    symbolize(obj).to_s
  end

  # Turns a String object into a camelCase Symbol.
  #
  # @param obj [Object] the String object to be camelized.
  #
  # @example Camelize a string using the camelize method
  #   SimpleSymbolize.camelize("hello world!") #=> :helloWorld
  def self.camelize(obj)
    return obj unless valid_input?(obj)

    first, *rest = elementize(obj).split('_')
    return obj if first.nil?

    if rest.size.positive?
      acronyms = SimpleSymbolize.translations.camel_case_acronyms
      rest = if acronyms.empty?
               rest.map(&:capitalize)
             else
               rest.map { |word| acronyms.include?(word) ? word.upcase : word.capitalize }
             end

      word = first + rest.join
      word.to_sym
    else
      symbolize(first)
    end
  end

  # Turns a String || Symbol into a snake_case Symbol
  #
  # @param obj [Object] the object to be snakeize
  #
  # @example Snakeize an object using the snakeize method
  #   SimpleSymbolize.snakeize('Hello World!') #=> :hello_world
  def self.snakeize(obj)
    return obj unless valid_input?(obj)

    obj.to_s
       .gsub(Regexp.union(SimpleSymbolize.translations.underscore), '_')
       .gsub(Regexp.union(SimpleSymbolize.translations.remove), '')
       .gsub(/([a-z\d])([A-Z])/, '\1_\2')
       .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
       .downcase
       .to_sym
  end

  # Validates if the input object should be processed
  #
  # @param obj [Object] the object to validate
  # @return [Boolean] true if the object should be processed, false otherwise
  def self.valid_input?(obj)
    return false unless [String, Symbol].include?(obj.class)
    return false unless obj.respond_to?(:to_s)
    return false if obj.to_s.empty?

    true
  end

  private_class_method :valid_input?
end
