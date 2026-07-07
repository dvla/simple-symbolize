# frozen_string_literal: true

# Extends the Symbol class by mixing in the symbolize module.
# @example Mixin the methods to the Symbol class
#   Symbol.include SimpleSymbolize::CoreExt::Symbol

module SimpleSymbolize
  module CoreExt
    # Contains methods to be mixed into the String class
    module Symbol
      # @example Symbolize a string using the String object method
      #   :hello_world!.symbolize #=> :hello_world
      def simple_symbolize(strip_chars: true)
        SimpleSymbolize.symbolize(self, strip_chars:)
      end

      # @example Turns a String into a camelCase Symbol
      #   :hello_world.simple_camelize => :helloWorld
      def simple_camelize(strip_chars: true)
        SimpleSymbolize.camelize(self, strip_chars:)
      end

      # @example Symbolizes a String then calls #to_s
      #   :helloWorld!.simple_elementize => 'hello_word'
      def simple_elementize(strip_chars: true)
        SimpleSymbolize.elementize(self, strip_chars:)
      end

      # @example Turns a String into it's snake_case equivalent
      #   :helloWorld.simple_snakeize => :hello_word
      def simple_snakeize(strip_chars: true)
        SimpleSymbolize.snakeize(self, strip_chars:)
      end
    end
  end
end
