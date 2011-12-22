goliath-rack
============

So Goliath is ["mostly Rack-compatible" but "not Rack-compliant"][1].
I'm just fooling with some stuff to see how far we can go towards running
arbitrary Rack apps side-by-side with <tt>Goliath::API</tt> subclasses.

Currently we can run a Sinatra app in Goliath, via <tt>rackup</tt>.

Onwards!

[1]: http://groups.google.com/group/goliath-io/browse_thread/thread/167360dd47c054a