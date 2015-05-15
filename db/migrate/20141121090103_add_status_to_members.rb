class AddStatusToMembers < ActiveRecord::Migration
  def change
    add_column :members, :status, :string, :null => false, :default => 'Active'
    add_index :members, :status
  end
end
