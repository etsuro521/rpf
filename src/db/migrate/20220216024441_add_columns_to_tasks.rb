class AddColumnsToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :urgency_importance, :string
    add_column :tasks, :status, :string
    add_column :tasks, :notes, :text
  end
end
