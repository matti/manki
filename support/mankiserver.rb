require 'sinatra'

set :static, true
set :public_folder, 'www'

get '/' do
  send_file File.expand_path('index.html', settings.public_folder)
end
