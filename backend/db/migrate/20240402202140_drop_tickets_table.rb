class DropTicketsTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :tickets
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
