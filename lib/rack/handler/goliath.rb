require 'goliath/server'
require 'log4r'
require 'rack'
require 'async-rack'

module Rack
	module Handler
    
    register 'goliath', 'Rack::Handler::Goliath'

    class Goliath
      include ::Goliath::Constants
      EXTENSION = /\./
      LEADING_SLASH = /^\//
      def self.run(app, options={}, &blk)
        server = ::Goliath::Server.new(options[:Host] || '0.0.0.0',
                                       options[:Port] || 8080)
        logger = Log4r::Logger.new('Goliath')
        logger.outputters=[Log4r::IOOutputter.new('stderr', STDERR)]
        server.app = lambda do |env|
          env[RACK_LOGGER] ||= logger
          env[RACK_ERRORS] ||= logger
          env['rack.url_scheme'] = 'http'
          env['SCRIPT_NAME'] = ''
          safeenv = env.reject{|k,v|!k.is_a?(String) || (k !~ EXTENSION && !v.is_a?(String))}
          app.call(safeenv)
        end
        server.start(&blk)
      end

      def self.valid_options
        {
          "Host=HOST" => "Hostname to listen on (default: localhost)",
          "Port=PORT" => "Port to listen on (default: 8080)",
        }
      end
    end
  end
end
