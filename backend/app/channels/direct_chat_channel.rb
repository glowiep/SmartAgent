class DirectChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "direct_chat"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end