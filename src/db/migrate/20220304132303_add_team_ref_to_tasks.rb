class AddTeamRefToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :team, null: true, foreign_key: true
  end
end
