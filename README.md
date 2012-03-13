David - defeating Goliath for your Rack apps
============================================

So Goliath is ["mostly Rack-compatible" but "not Rack-compliant"][1].
I'm just fooling with some stuff to see how far we can go towards running
arbitrary Rack apps side-by-side with <tt>Goliath::API</tt> subclasses.

Currently we can run a Sinatra app in Goliath, via <tt>rackup</tt>.

    require 'david/rack'
    require 'goliath'

    class MyApp < Sinatra::Base
      # your app here :)
    end
    
    # you need to instantiate this before you subclass Goliath::API for the last time.
    rack_app = David::RackAdaptor.build(:once => true) { MyApp.new }

    class MyGoliathApp < Goliath::API
      map '/rack_app', rack_app
    end

Onwards!

[1]: http://groups.google.com/group/goliath-io/browse_thread/thread/167360dd47c054a