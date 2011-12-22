require 'goliath'
require 'sinatra/base'
require 'rack/handler/goliath'

class MyApp < Sinatra::Base
  get '/' do
    'hello'
  end
end

class SinatraAdaptor
  def self.for(klass)
    sinatra_app = klass.new
    c = Class.new(Goliath::API) do
      define_method :response do |env|
        puts "Mine"
        sinatra_app.call(env)
      end
    end
    const_set klass.name, c
    Goliath::API.inherited(const_get(klass.name))
    c
  end
end

class Foo < Goliath::API
  def response(env)
    [200, {}, 'bobby']
  end
end

MYAPP_ADAPTOR = SinatraAdaptor.for(MyApp)

module Goliath
  class RackApp < Goliath::API
    map '/', MYAPP_ADAPTOR
    map '/fool', Foo
  end
end
