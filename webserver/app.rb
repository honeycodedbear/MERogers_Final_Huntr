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

post '/swipe' do
  user_a = params[:user_a]
  user_b = params[:user_b]
  #create a like following for user_a to user_b
  #if params[:direction] == 'right'
  #then make it a like
  #else make it a dislike
  content_type :json
  { message: "Success" }.to_json
end

get '/random_user' do
  content_type :json
  user = User.find(params[:user_id])
  #check if user is user's ownself. if so find another one
  #also add gender
  do
    target = User.where("isEmployer = ?",!params[:isEmployer]).sample(1) #we pick one of the random wanted users
  while target.liked_by.where("userB_id = ?",params[:user_id]).count > 0 && target.likes.where("userA_id = ?",params[:user_id]).count > 0
  target.to_json
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
