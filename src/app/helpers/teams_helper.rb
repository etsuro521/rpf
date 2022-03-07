module TeamsHelper

    def my_teams
        @teams = current_user.join_teams.where(group_id:current_group.id)
    end

    def has_teams?
        current_user.join_teams.where(group_id:current_group.id).count > 0
    end

    def remember_team(team)
        cookies.permanent.signed[:team_id] = team.id
    end

    def current_team
        if team_id = cookies.signed[:team_id]
            @current_team = current_user.join_teams.find_by(id:team_id)
        end
        if @current_team 
            return @current_team
        elsif has_teams?()
            remember_team(current_user.join_teams.find_by(name:'general'))
            return current_user.join_teams.first
        end
    end

end

