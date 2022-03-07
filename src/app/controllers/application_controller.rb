class ApplicationController < ActionController::Base
    include SessionsHelper
    include GroupsHelper
    include TeamsHelper

    private
        def logged_in_user
            unless logged_in?
                store_location
                redirect_to login_url
            end
        end

        def group_admin_user
            @user_group = current_user.user_groups.find_by(group_id:params[:id])
            unless @user_group.admin
                flash[:danger] = 'このグループの管理者ではありません'
                redirect_to current_user 
            end
        end

        def admin_user
            group_id = UserGroup.find_by(id:params[:id]).group_id
            @user_group = UserGroup.find_by(user_id:current_user.id,group_id:group_id)
            unless @user_group.admin
                flash[:danger] = 'このグループの管理者ではありません'
                redirect_to current_user 
            end
        end

        def user_has_group
            unless has_group?(current_user)
                flash[:danger] = 'チームを管理するにはグループを作る必要があります'
                redirect_to @current_user
            end
        end

        def user_added_team
            @user_team = current_user.user_teams.find_by(team_id:params[:id])
            if @user_team.nil?
                flash[:danger] = 'このチームには所属していません'
                redirect_to root_path  
            end
        end
end
