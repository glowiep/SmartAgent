class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.references :request, null: false, foreign_key: true
      t.text :body
      t.boolean :from_customer

      t.timestamps
    end
  end
end
