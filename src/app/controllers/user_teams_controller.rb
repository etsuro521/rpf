class UserTeamsController < ApplicationController
    before_action :logged_in_user
    before_action :user_has_group

    def destroy
        @user_team = UserTeam.find(params[:id])
        @team = Team.find(@user_team.team_id)
        user_id = @user_team.user_id
        @user_team.destroy
        if @team.members.count > 0
            redirect_to (user_id == current_user.id ?  root_path : @team)
        else
            render 'teams/confirm'
        end
    end
end
