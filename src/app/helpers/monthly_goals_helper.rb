module MonthlyGoalsHelper
    def step_by_unit(head,tail, unit = :day, step = 1)  
        Enumerator.new do |yielder|
          while head <= tail
            yielder << head
            head += step.send(unit)
          end
        end
    end

    def get_months()
        now = Date.today()
        head = Date.new(now.year,1)
        tail = Date.new(now.year,12)
        months = step_by_unit(head,tail,:month)
    end

    def monthly_create_or_edit?(d)
        d = d.to_datetime()
        goals = stored_team.monthly_goals.where(month:d)
        goals.exists? ? true : false
    end
end
