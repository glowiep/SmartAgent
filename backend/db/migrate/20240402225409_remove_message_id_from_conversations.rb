class RemoveMessageIdFromConversations < ActiveRecord::Migration[7.1]
  def change
    remove_column :conversations, :message_id, :string
  end
end
