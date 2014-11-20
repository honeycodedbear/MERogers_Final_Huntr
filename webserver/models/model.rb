require 'bcrypt'
require 'sinatra/activerecord'
class User < ActiveRecord::Base
  has_secure_password
	validates_presence_of :password, :on => :create
  has_many :likes, foreign_key: 'userB_id'
  has_many :liked_by, class_name: "Like", foreign_key: 'userA_id'
end

class Like < ActiveRecord::Base
  belongs_to :userA, class_name: 'User'
  belongs_to :userB, class_name: 'User'
end
