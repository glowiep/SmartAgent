class RenameRequestsToTickets < ActiveRecord::Migration[7.1]
  def change
    rename_table :requests, :tickets
  end
end
