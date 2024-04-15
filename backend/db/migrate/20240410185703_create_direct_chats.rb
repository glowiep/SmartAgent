class CreateDirectChats < ActiveRecord::Migration[7.1]
  def change
    create_table :direct_chats do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.text :message

      t.timestamps
    end
  end
end
