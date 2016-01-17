$:.push File.expand_path("../lib", __FILE__)
require 'abuelo/version'

Gem::Specification.new do |spec|
  spec.name        = 'Abuelo'
  spec.version     = Abuelo::VERSION
  spec.date        = '2016-01-10'
  spec.summary     = "Abuelo"
  spec.description = "Abuelo is a graph theory library."
  spec.authors     = ["Dirk Holzapfel"]
  spec.email       = 'dirk@bitcrowd.net'
  spec.files       = ["lib/abuelo.rb"]
  spec.homepage    =
    'http://github.com/dirkholzapfel/abuelo'
  spec.license       = 'MIT'

  # Development
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'

  # Testing
  spec.add_development_dependency 'rspec'
end