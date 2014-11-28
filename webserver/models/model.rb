require 'bcrypt'
require 'sinatra/activerecord'
class User < ActiveRecord::Base
  has_secure_password
	validates_presence_of :password, :on => :create
  has_many :likes, foreign_key: 'userB_id'
  has_many :liked_by, class_name: "Like", foreign_key: 'userA_id'
  has_many :sent_messages, class_name: "Message", foreign_key: 'sending_user_id'
  has_many :recieved_messages, class_name: "Message", foreign_key: 'receiving_user_id'

  def getConversation(userB)
    (sent_messages.where("receiving_user_id = ?",userB.id)+recieved_messages.where("sending_user_id = ?",userB.id)).to_json
  end

  def self.getConversation(userA: nil, userB: nil)
    sent_messages = userA.sent_messages.where("receiving_user_id = ?",userB.id)
    recieved_messages = userA.recieved_messages.where("sending_user_id = ?",userB.id)
    (sent_messages+recieved_messages).to_json
  end

  def self.getConversations(userA: nil)
    user_ids = []
    user_ids += userA.sent_messages.collect {|m| m.receiving_user.id}
    user_ids += userA.recieved_messages.collect {|m| m.sending_user.id}
    user_ids.uniq.to_json
  end
end

class Like < ActiveRecord::Base
  belongs_to :userA, class_name: 'User'
  belongs_to :userB, class_name: 'User'
end

class Message < ActiveRecord::Base
  belongs_to :sending_user, foreign_key: "sending_user_id", class_name: "User"
  belongs_to :receiving_user, foreign_key: "receiving_user_id", class_name: "User"
end
