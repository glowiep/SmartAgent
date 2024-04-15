class RemoveBodyFromRequests < ActiveRecord::Migration[7.1]
  def change
    remove_column :requests, :body, :text
  end
end
