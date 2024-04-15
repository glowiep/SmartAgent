# app/channels/conversations_channel.rb
class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversations"
  end
end