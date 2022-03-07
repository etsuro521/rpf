class AddDetailsToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :to, :string
    add_column :tasks, :from, :string
  end
end
