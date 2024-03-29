# frozen_string_literal: true

require_relative 'lib/simple_symbolize/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_symbolize'
  spec.version       = SimpleSymbolize::VERSION
  spec.authors       = ['alexo', 'Driver and Vehicle Licensing Agency (DVLA)']
  spec.email         = ['']

  spec.summary       = 'Turns Strings into Symbols.'
  spec.description   = 'simple_symbolize will remove special characters from a String, ' \
                       'replacing whitespace with an underscore, ' \
                       'down-casing and finally calling the #to_sym String method. ' \
                       'Configure this gem to your hearts content!'
  spec.homepage      = 'https://github.com/dvla/simple-symbolize'

  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.12'
  spec.add_development_dependency 'rubocop', '~> 1.54'
  spec.add_development_dependency 'simplecov', '~> 0.22'
end
