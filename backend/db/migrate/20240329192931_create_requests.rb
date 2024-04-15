class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.string :from_email, null: false
      t.string :customer_name, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
