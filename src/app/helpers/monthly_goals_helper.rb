module MonthlyGoalsHelper
  def step_by_unit(head,tail, unit = :day, step = 1)  
    Enumerator.new do |yielder|
      while head <= tail
        yielder << head
        head += step.send(unit)
      end
    end
  end

  def get_months(year)
    head = Date.new(year.to_i,1)
    tail = Date.new(year.to_i,12)
    months = step_by_unit(head,tail,:month)
  end

  def monthly_create_or_edit?(d)
    d = d.to_datetime()
    goals = stored_team.monthly_goals.where(month:d)
    goals.exists? ? true : false
  end

  def get_team_month()
    goals_month =  stored_team.weekly_goals.pluck(:month)
    result = goals_month.group_by { |a| a.strftime('%Y') }.map do |year, array|
      [year, array.count]
    end.to_h
    result.keys
  end
  
end
