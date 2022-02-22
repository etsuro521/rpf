class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :tasks, [:user_id, :created_at]
  end
end
