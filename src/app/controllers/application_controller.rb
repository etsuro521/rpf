class ApplicationController < ActionController::Base
    include SessionsHelper
    include GroupsHelper
    include TeamsHelper
    include MonthlyGoalsHelper
    include WeeklyGoalsHelper

    rescue_from Exception, with: :error500
    rescue_from ActiveRecord::RecordNotFound,ActionController::RoutingError,with: :error404

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
                flash[:danger] = 'To manage a team, you need to create a group'
                redirect_to @current_user
            end
        end

        def group_member
            if stored_team.nil?
                flash[:danger] = 'Please select a team to display your goals'
                redirect_to root_path
            else
                group = Group.find_by(id:stored_team.group_id)
                unless group.members.exists?(id:current_user)
                    flash["danger"] = "You don't belong to this group."
                    redirect_to root_path  
                end
            end
            
        end

        def store_date
            unless !session[:date].nil?
                flash[:danger] = 'Please select the month of Goals'
                redirect_to (!session[:team_id].nil? ? goals_path : root_path)
            end
        end

        def error404(e)
            render "error404",status: 404, formats: [:html]
        end

        def error500(e)
            logger.error [e,*e.backtrace].join("\n")
            render "error500", status: 500, formats: [:html]
        end

end
