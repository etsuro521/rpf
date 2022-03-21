class WeeklyGoal < ApplicationRecord
    belongs_to :team

    with_options presence: true do
        validates :team_id
        validates :month
        validates :whose
        validates :week, inclusion: { in: %w(１週目 ２週目 ３週目 ４週目 ５週目) }
        validates :plan, length: { maximum: 500 }
        validates :action, length: { maximum: 500 }
    end
    validates :output, length: { maximum: 500 }
    validates :review, length: {maximum: 500}
    
    attr_accessor :check

end
