class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.references :agent, foreign_key: true
      t.references :request, foreign_key: true
      t.references :status, foreign_key: true
      t.timestamps
    end
  end
end
