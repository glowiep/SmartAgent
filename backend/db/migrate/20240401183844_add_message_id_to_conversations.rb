class AddMessageIdToConversations < ActiveRecord::Migration[7.1]
  def change
    add_column :conversations, :message_id, :string
  end
end
