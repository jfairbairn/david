require 'sinatra'



class MyApp < Sinatra::Application
	get '/' do
		content_type 'text/html'
		'<html><body>hello world</body></html>'
	end
end