class ApplicationController < ActionController::Base
    include SessionsHelper
    include GroupsHelper
    include TeamsHelper
    include MonthlyGoalsHelper
    include WeeklyGoalsHelper

    private
        def logged_in_user
            unless logged_in?
                store_location
                redirect_to login_url
            end
        end


        def user_addded_group
            
        end

        def user_has_group
            unless has_group?(current_user)
                flash[:danger] = 'チームを管理するにはグループを作る必要があります'
                redirect_to @current_user
            end
        end

        def group_member
            if stored_team.nil?
                flash[:danger] = '目標を表示するチームを選んでください'
                redirect_to root_path
            else
                group = Group.find_by(id:stored_team.group_id)
                unless group.members.exists?(id:current_user)
                    flash["danger"] = "このグループには所属していません"
                    redirect_to root_path  
                end
            end
            
        end

        def store_date
            unless !session[:date].nil?
                flash[:danger] = '月を選択してください'
                redirect_to (!session[:team_id].nil? ? goals_path : root_path)
            end
        end

end
