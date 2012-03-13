require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'david'))

Gem::Specification.new do |s|
	s.name = 'david'
  s.summary = 'Defeating Goliath for your Rack apps'
  s.version = David::VERSION
  s.authors = ['James Fairbairn']
  s.email = ['james@netlagoon.com']
  s.required_ruby_version = '>= 1.9.1'
  
  s.add_dependency 'goliath', '>= 0.9.4'

  s.files = `git ls-files`.split(/\r?\n/)
  s.require_paths = ['lib']
end