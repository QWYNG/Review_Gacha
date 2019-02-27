require 'sinatra'
require 'json'

post '/' do
  # Might want to add a token read from env variable
  #status 500 unless request['token'] == 'your-token-here'

  text = "HelloWorld!"

  content_type :json
  {
    title: 'TMNT Gifs',
    text: text,
  }.to_json
end
