require 'rack/session/cookie'
require 'action_dispatch'

module ActionDispatch
  class MiddlewareStack
    alias_method :old_assert_index, :assert_index
    def assert_index(index, where)
      old_assert_index(index, where)
    rescue => e
      if index.is_a?(String) && index =~ /^Rack::(.*)$/
        old_assert_index("AsyncRack::#{$1}", where)
      else
        raise e
      end
    end
  end
end

Rack::Chunked = AsyncRack::Chunked

module David
  class RailsAdaptor
    def self.build(rails_root)
      require "#{rails_root}/config/environment"
      app = Rails.application
      c=Class.new(Goliath::API) do
        define_method :response do |env|
          app.call(env)
        end
      end
      const_set 'Application', c
      c
    end
  end
end