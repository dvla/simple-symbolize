require 'symbolize/version'

require_relative 'symbolize/string.rb'
require_relative 'symbolize/translations.rb'

module Symbolize
  class Error < StandardError; end

  def self.translations
    @translations ||= Translations.new
  end

  def self.translate
    yield translations
  end

  def self.symbolize(str)
    return str if str.is_a?(Symbol) || str.nil?
    str.downcase.tr(translations.underscore.join, '_')&.tr(translations.remove.join, '')&.to_sym
  end
end
