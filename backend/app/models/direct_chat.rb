class DirectChat < ApplicationRecord
  belongs_to :sender, class_name: 'Agent'
  belongs_to :receiver, class_name: 'Agent'
  after_create_commit :broadcast_message

  private

  def broadcast_message
    ActionCable.server.broadcast(
      "direct_chat",
      self
    )
  end
end
