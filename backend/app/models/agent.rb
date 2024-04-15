class Agent < ApplicationRecord
  has_secure_password
  has_many :tickets
  has_many :sent_chats, class_name: 'DirectChat', foreign_key: 'sender_id'
  has_many :received_chats, class_name: 'DirectChat', foreign_key: 'receiver_id'  
end
