require File.expand_path(File.join(File.dirname(__FILE__), 'goliath-rack'))

Gem::Specification.new do |s|
	s.name = 'goliath-rack'
  s.version = Goliath::Rack::VERSION
  s.authors = ['James Fairbairn']
  s.email = ['james@netlagoon.com']
  s.required_ruby_version = '>= 1.9.2'
  
  s.add_dependency 'goliath', '~> 0.9.4'
  s.add_dependency 'rack', '~> 1.3.5'

  s.add_development_dependency 'sinatra', '~> 1.3.1'
  s.add_development_dependency 'thin', '~> 1.2.11'
  s.require_paths = ['lib']
end