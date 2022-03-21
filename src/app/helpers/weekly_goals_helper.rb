module WeeklyGoalsHelper
    def weekly_create_or_edit?(d)
        d = d.to_datetime()
        goals = stored_team.weekly_goals.where(month:d)
        goals.exists? ? true : false
    end

    def get_weeks(team,month)
        weeks = team.weekly_goals.select(:week).where(month:month).distinct
    end

    def get_whose(team,month)
        whose = team.weekly_goals.select(:whose).where(month:month).distinct
    end

    def get_whose_name(id)
        id = "0" if id.nil?
        id == "0" ? stored_team.name : User.find_by(id:id).name
    end

    def week_of_month(date)
        first_week = (date - (date.day - 1)).cweek
        this_week = date.cweek
      
        if this_week < first_week
          
          if date.month == 12
            return (week_of_month(date - 7) + 1).to_s().tr("A-Z0-9","Ａ-Ｚ０-９")
            
          else
            return (this_week + 1).to_s().tr("A-Z0-9","Ａ-Ｚ０-９")
          end
        end
        
        return (this_week - first_week + 1).to_s().tr("A-Z0-9","Ａ-Ｚ０-９")
    end

    def default_week(team,date)
        week = week_of_month(Date.today) + "週目"
        goals = team.weekly_goals.where(month:date.to_datetime(),week:week)
        return goals.exists? ? week : team.weekly_goals.where(month:date.to_datetime()).first.week
    end

    def default_whose(team,date)
        id = team.weekly_goals.where(month:date.to_datetime()).first.whose
        team_goals = team.weekly_goals.where(month:date.to_datetime())
        user_goals = team.weekly_goals.where(whose:current_user.id,month:date.to_datetime())
        if user_goals.exists?
            return current_user.id
        elsif team_goals.exists?
            return "0"
        else
            return id
        end
    end
end
