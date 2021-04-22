require 'Symbolize'

class String
  def symbolize
    Symbolize.symbolize(self)
  end
end