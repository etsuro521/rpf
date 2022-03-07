class AddIndexTasks < ActiveRecord::Migration[6.0]
  def change
    add_index :tasks , [:user_id,:group_id]
  end
end
