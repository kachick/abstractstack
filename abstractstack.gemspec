# coding: us-ascii

# I don't know why dose occur errors below.
#  require_relative 'lib/abstractstack/version'
require File.expand_path('../lib/abstractstack/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.summary       = %q{A template of Stack classies}
  gem.description   = gem.summary.dup
  gem.homepage      = 'http://kachick.github.com/abstractstack/'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'abstractstack'
  gem.require_paths = ['lib']
  gem.version       = AbstractStack::VERSION.dup # dup for https://github.com/rubygems/rubygems/commit/48f1d869510dcd325d6566df7d0147a086905380#-P0

  gem.required_ruby_version = '>= 1.9.2'

  gem.add_development_dependency 'yard', '~> 0.8'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake'
end