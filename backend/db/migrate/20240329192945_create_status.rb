class CreateStatus < ActiveRecord::Migration[7.1]
  def change
    create_table :statuses do |t|
      t.string :description, null: false
      t.timestamps
    end
  end
end
