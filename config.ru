require 'sinatra'
require 'cgi'

WIDGET = File.open('widget.html').read

get '/' do
  <<-EOF
<!doctype html>
<style>
body { font-family: sans-serif; }
p { max-width: 900px; margin: 0 auto; }
</style>
<p>Usage: <code>&lt;iframe src="https://better-patreon-widget.herokuapp.com/widget?u={{user_id}}"&gt;&lt;/iframe&gt;</code></p>
<p>Replace <code>{{user_id}}</code> with your Patreon user ID.</p>
<p>&nbsp;</p>
<p>TODO: Document how to find your user ID.</p>
  EOF
end

get '/widget' do
  user_id = params[:u]
  redirect_uri = CGI.escape(params[:redirect_uri] || '')

  WIDGET
    .gsub('{{user_id}}', user_id)
    .gsub('{{redirect_uri}}', redirect_uri)
end

run Sinatra::Application
