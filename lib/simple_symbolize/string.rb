# frozen_string_literal: true

require 'simple_symbolize'

# Extends the String class by mixing in the symbolize module.
class String
  # @example Symbolize a string using the String object method
  #   "hello world!".symbolize #=> :hello_world
  def symbolize
    SimpleSymbolize.symbolize(self)
  end

  # @example Turns a String into it's snake_case equivalent
  #   "helloWorld".to_snake_case => 'hello_word'
  def to_snake_case
    # rubocop:disable Style/RedundantSelf
    self.gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .downcase
    # rubocop:enable Style/RedundantSelf
  end
end
