# frozen_string_literal: true

# Extends the String class by mixing in the symbolize module.
# @example Mixin the methods to the String class
#   String.include SimpleSymbolize::CoreExt::String

module SimpleSymbolize
  module CoreExt
    # Contains methods to be mixed into the String class
    module String
      # @example Symbolize a string using the String object method
      #   "hello world!".symbolize #=> :hello_world
      def simple_symbolize
        SimpleSymbolize.symbolize(self)
      end

      # @example Turns a String into a camelCase Symbol
      #   "Hello World".simple_camelize => :helloWorld
      def simple_camelize
        SimpleSymbolize.camelize(self)
      end

      # @example Symbolizes a String then calls #to_s
      #   "helloWorld".simple_elementize => 'hello_word'
      def simple_elementize
        SimpleSymbolize.elementize(self)
      end

      # @example Turns a String into it's snake_case equivalent
      #   "helloWorld".simple_snakeize => 'hello_word'
      def simple_snakeize
        SimpleSymbolize.snakeize(self)
      end
    end
  end
end
