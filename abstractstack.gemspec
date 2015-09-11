# coding: us-ascii

require File.expand_path('../lib/abstractstack/version', __FILE__)

Gem::Specification.new do |gem|
  # specific

  gem.summary       = %q{A template of stack APIs}
  gem.description   = gem.summary.dup
  gem.homepage      = 'http://kachick.github.com/abstractstack/'

  gem.name          = 'abstractstack'
  gem.version       = AbstractStack::VERSION.dup # dup for https://github.com/rubygems/rubygems/commit/48f1d869510dcd325d6566df7d0147a086905380#-P0

  gem.required_ruby_version = '>= 2.0.0'

  gem.add_development_dependency 'yard', '>= 0.8.7.6', '< 0.9'
  gem.add_development_dependency 'rake', '>= 10', '< 20'
  gem.add_development_dependency 'bundler', '>= 1.10', '< 2'
  gem.add_development_dependency 'test-unit', '>= 3.1.1', '< 4'

  # common

  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
