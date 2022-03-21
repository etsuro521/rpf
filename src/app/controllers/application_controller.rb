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

end
