require 'goliath/api'

module David
  class RackAdaptor
    def self.build(opts, &blk)
      once = !! opts[:once]

      rack_app = blk.call
      c = Class.new(Goliath::API) do
        define_method :response do |env|
          env['rack.url_scheme'] ||= 'http'
          env['SCRIPT_NAME'] = ''
          if once
            rack_app.call(env)
          else
            blk.call.call(env)
          end
        end
      end
      classname = rack_app.class.name.gsub(/.*::/, '')
      const_set classname, c
      Goliath::API.inherited(const_get(classname))
      c
    end
  end
end
