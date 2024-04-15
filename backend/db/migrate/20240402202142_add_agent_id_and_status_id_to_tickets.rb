class AddAgentIdAndStatusIdToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :agent_id, :bigint
    add_column :tickets, :status_id, :bigint
    add_index :tickets, :agent_id
    add_index :tickets, :status_id
  end
end
