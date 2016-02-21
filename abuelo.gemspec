$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'abuelo/version'

Gem::Specification.new do |spec|
  spec.name        = 'abuelo'
  spec.version     = Abuelo::VERSION
  spec.date        = '2016-01-10'
  spec.summary     = 'Abuelo'
  spec.description = 'Abuelo is a graph theory library.'
  spec.authors     = ['Dirk Holzapfel']
  spec.email       = 'cache.zero@mailbox.org'
  spec.homepage    =
    'http://github.com/dirkholzapfel/abuelo'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Development
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'

  # Testing
  spec.add_development_dependency 'rspec'
end
