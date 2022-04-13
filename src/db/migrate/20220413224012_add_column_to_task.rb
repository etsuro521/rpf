class AddColumnToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :updater, :string
  end
end
