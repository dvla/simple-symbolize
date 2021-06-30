require 'simple_symbolize'

# Extends the String class by mixing in the symbolize module.
class String
  # @example Symbolize a string using the String object method
  #   "hello world!".symbolize #=> :hello_world
  def symbolize
    SimpleSymbolize.symbolize(self)
  end
end
