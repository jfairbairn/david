require 'goliath'

module Rack
  module Handler
    class Goliath
      def self.run(rack_app, options={})
        # server = ::Thin::Server.new(options[:Host] || '0.0.0.0',
        #                             options[:Port] || 8080,
        #                             app)
        argv = "-p #{options[:Port] || 8080}"
        api = rack_app.new

        runner = Goliath::Runner.new(ARGV, api)
        runner.app = Goliath::Rack::Builder.build(rack_app, api)

        runner.load_plugins(rack_app.plugins)

        yield runner if block_given?
        runner.run
      end

      def self.valid_options
        {
          "Host=HOST" => "Hostname to listen on (default: localhost)",
          "Port=PORT" => "Port to listen on (default: 8080)",
        }
      end
    end

    register 'goliath', 'Rack::Handler::Goliath'

  end
end
require 'rack/session/cookie'