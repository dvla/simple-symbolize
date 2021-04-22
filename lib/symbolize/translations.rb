module Symbolize
  class Translations

    attr_accessor :underscore, :remove

    def initialize
      @underscore = [' ']
      @remove = ['\'','(',')']
    end

    def to_underscore(t)
      @underscore |= t.chars
      @remove -= t.chars
    end

    def to_remove(t)
      @remove |= t.chars
      @underscore -= t.chars
    end
  end
end