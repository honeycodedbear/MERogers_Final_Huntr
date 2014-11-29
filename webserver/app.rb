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

get '/inbox_users' do
  content_type :json
  user_ids = User.getInboxUsers userA: User.find(params[:user_id])
  user_ids
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
  puts params.inspect
  #{ message: "Failure" }.to_json
  User.where("id != ?",params[:user_id]).sample(1).first.to_json
end

get '/user' do
  content_type :json
  return User.find(params[:user_id]).to_json unless params[:user_id].nil?
  { message: "Failure" }.to_json
end

post '/update_user' do
  content_type :json
  puts params.inspect
  user = User.find(params[:user_id])
  user.name = params[:name]
  user.dev_type = params[:dev_type]
  user.location = params[:location]
  user.blurb = params[:blurb]
  user.skill1 = params[:skill1]
  user.skill2 = params[:skill2]
  user.skill3 = params[:skill3]
  user.skill4 = params[:skill4]
  user.skill5 = params[:skill5]
  user.skill6 = params[:skill6]
  user.github = params[:github]
  user.personal = params[:personal]
  user.employer = params[:employer]
  user.save
  { message: "Success" }.to_json
end

get '/get_image' do
  content_type 'image/png'
  File.open("./public/profile_image_#{params[:user_id]}.png").read
end

post '/save_image' do
  content_type :json
  #puts params.inspect
  #@filename = params[:file][:filename]
  File.open("./public/profile_image_#{params[:user_id]}.png", 'wb') do |f|
    f.write(params[:image])
  end
  user = User.find(params[:user_id])
  user.profile_img = "has one"
  user.save
  #erb :show_image
  return { message: "Success" }.to_json
end

get '/signup' do
  content_type :json
  puts params.inspect
  if @user = User.find_by(email:  params[:email])
    { message: "Failure" }.to_json
  else
    { message: "Success", user_id: @user.id.to_s }.to_json
  end
end

get '/login' do
  content_type :json
  puts params.inspect
  if(@user = User.find_by(email:  params[:email]).try(:authenticate, params[:password]))
    { message: "Success", user_id: @user.id.to_s }.to_json
  else
    { message: "Failure" }.to_json
  end
end
