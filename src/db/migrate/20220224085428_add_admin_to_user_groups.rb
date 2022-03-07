class AddAdminToUserGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :user_groups, :admin, :boolean, default: false, null: false
  end
end
