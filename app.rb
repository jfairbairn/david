require 'goliath'
require 'sinatra/base'
require 'goliath/websocket'
# require 'rack/handler/goliath'


class MyApp < Sinatra::Base
  get '/' do
    haml :index
  end
end

class SinatraAdaptor
  def self.for(klass)
    sinatra_app = klass.new
    c = Class.new(Goliath::API) do
      define_method :response do |env|
        puts env['PATH_INFO']
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

class WSocket < Goliath::WebSocket
  def on_open(env)
  end

  def on_message(env, msg)
    env.logger.debug(msg)
    env.handler.send_text_frame msg
  end

  def on_close(env)
  end

  def on_error(env, error)
    # env.logger.error error
  end
end

RAILS_ADAPTOR = RailsAdaptor.for(Rails.application)
SINATRA_ADAPTOR = SinatraAdaptor.for(MyApp)

module Goliath
  class RackApp < Goliath::API
    map '/rails/*', RAILS_ADAPTOR
    map '/sinatra/*', SINATRA_ADAPTOR
    map '/fool', WSocket
    def response(env)
      [404, {}, '404 Not found']
    end
  end
end
