require 'sinatra'
require 'json'
require 'rmagick'
require 'httparty'

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

get '/user_name' do
  content_type :json
  {name: User.find(params[:user_id]).name }.to_json
end

get '/conversation' do
  content_type :json
  User.getConversation userA:User.find(params[:user_id]), userB:User.find(params[:other_id])
end

post '/send_message' do
  content_type :json
  Message.create sending_user_id: params[:user_id], receiving_user_id: params[:other_id], data: params[:data]
  {message: "Success"}.to_json
end

post '/swipe' do
  content_type :json
  userA = User.find(params[:user_id])
  userB = User.find(params[:target_id])
  #create new like
  Match.create userA_id: userA.id, userB_id: userB.id
  #check if there is a match
  doesAlikeB = !Match.where("userA_id =? AND userB_id = ?", userA.id, userB.id).empty?
  doesBlikeA = !Match.where("userA_id =? AND userB_id = ?",userB.id, userA.id).empty?
  if doesAlikeB && doesBlikeA

    Message.create sending_user_id: userA.id, receiving_user_id: userB.id, data: "Hey! We are a MATCH!!"
    #Code to do a push notification

    return {message: "Success"}.to_json
  else
    return {message: "Failure"}.to_json
  end
end

get '/random_user' do
  content_type :json
  puts params.inspect
  #{ message: "Failure" }.to_json
  u = User.find(params[:user_id])
  User.where("id != ? AND employer != ?",u.id, u.employer).sample(1).first.to_json
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

  begin
    File.open("./public/profile_image_#{params[:user_id]}.png").read
  rescue
    File.open("./public/profile_image_-1.png").read
  end
end

get '/get_image_thumb' do
  content_type 'image/png'
  begin
    File.open("./public/profile_image_#{params[:user_id]}_thumb.png").read
  rescue
    File.open("./public/profile_image_-1_thumb.png").read
  end
end

get '/get_user' do
  content_type :json
  User.find(params[:target_user_id]).to_json
end

post '/save_image' do
  content_type :json
  #puts params.inspect
  #@filename = params[:file][:filename]
  File.open("./public/profile_image_#{params[:user_id]}.png", 'wb') do |f|
    f.write(params[:image])
  end
  #resize image
  Magick::Image::read("./public/profile_image_#{params[:user_id]}.png").first.scale(100,100).write "./public/profile_image_#{params[:user_id]}_thumb.png"
  #update user
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
