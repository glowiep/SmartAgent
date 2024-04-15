class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.references :ticket, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
