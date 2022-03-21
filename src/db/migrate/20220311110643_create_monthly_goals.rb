class CreateMonthlyGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :monthly_goals do |t|
      t.references :team, foreign_key: true
      t.datetime :month
      t.text :plan
      t.text :action
      t.text :output
      t.text :review

      t.timestamps
    end
  end
end
