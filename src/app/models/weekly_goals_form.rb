class WeeklyGoalsForm
    include ActiveModel::Model
    
    GOAL_NUM = 5
    attr_accessor :collection,:whose,:week
    validates :week, presence: true
    validates :whose, presence: true


    def initialize(goals_params = [],other_params = [])
        if goals_params.present?
            self.collection = goals_params.map do |value|
                if value['check'] == "1"
                    WeeklyGoal.new(
                        month: value['month'].to_datetime,
                        team_id: value['team_id'],
                        week: other_params['week'],
                        whose: other_params['whose'],
                        plan: value['plan'],
                        action: value['action'],
                    )
                else
                    next
                end
            end.compact
        else
            self.collection = GOAL_NUM.times.map{ WeeklyGoal.new }
        end
    end

    def save
        is_success = true
        ActiveRecord::Base.transaction do
            collection.each do |result|
                is_success = false unless result.save
            end
            raise ActiveRecord::RecordInvalid unless is_success
        end
        rescue
            ActiveRecord::RecordInvalid
        ensure
            return is_success  
    end


end