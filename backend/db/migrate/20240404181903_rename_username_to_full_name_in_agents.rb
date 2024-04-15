class RenameUsernameToFullNameInAgents < ActiveRecord::Migration[7.1]
  def change
    rename_column :agents, :username, :full_name
  end
end
