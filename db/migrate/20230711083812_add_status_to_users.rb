class AddStatusToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :status, :string, default: 'active'
  end

  def down
    remove_column :users, :status
  end
end
