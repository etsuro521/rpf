class MonthlyGoal < ApplicationRecord
    belongs_to :team

    with_options presence: true do
        validates :team_id
        validates :month
        validates :plan, length: { maximum: 500 }
        validates :action, length: { maximum: 500 }
    end
    validates :output, length: { maximum: 500 }
    validates :review, length: {maximum: 500}
    
    attr_accessor :check
end
