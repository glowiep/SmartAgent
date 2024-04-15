# app/channels/tickets_channel.rb
class TicketsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'tickets'
  end
end
