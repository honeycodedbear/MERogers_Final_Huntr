require 'sinatra'
require 'json'
Dir["./models/*.rb"].each { |file| require file }

require './config/environments' #database configuration
configure do
  set :bind, '0.0.0.0'
  set :server, 'thin'
  enable :sessions
  set :session_secret, "My session secret"
end

get '/' do
  content_type :json
  { message: "Success" }.to_json
end

post '/' do
  puts params.inspect
  { message: "Success" }.to_json
end

get '/signup' do
  content_type :json
  puts params.inspect
  if @user = User.find_by(email:  params[:email])
    { message: "Failure" }.to_json
  else
    { message: "Success" }.to_json
  end
end

get '/login' do
  content_type :json
  puts params.inspect
  if @user = User.find_by(email:  params[:email]).try(:authenticate, params[:password])
    { message: "Success" }.to_json
  else
    { message: "Failure" }.to_json
  end
end
