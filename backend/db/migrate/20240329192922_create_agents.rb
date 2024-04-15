class CreateAgents < ActiveRecord::Migration[7.1]
  def change
    create_table :agents do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.string :password_digest, null: false  
      t.references :role, foreign_key: true  
      t.timestamps
    end
  end
end
