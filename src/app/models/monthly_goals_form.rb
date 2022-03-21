class MonthlyGoalsForm
  include ActiveModel::Model
  
  GOAL_NUM = 5
  attr_accessor :collection

  def initialize(attributes = [])
    if attributes.present?
      self.collection = attributes.map do |value|
        if value['check'] == "1"
          MonthlyGoal.new(
            month: value['month'].to_datetime,
            team_id: value['team_id'],
            plan: value['plan'],
            action: value['action']
          )
        else
          next
        end
      end.compact
    else
      self.collection = GOAL_NUM.times.map{ MonthlyGoal.new }
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
      p 'エラー'
    ensure
      return is_success  
  end

end