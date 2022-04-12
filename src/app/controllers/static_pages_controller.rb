class StaticPagesController < ApplicationController
    before_action :logged_in_user
    before_action :store_team, only:[:goals]

    def home
        store_location
        if my_task?()
            @tasks = current_group.tasks.order(updated_at: :asc).paginate(page: params[:page])
        else
            if cookies.permanent.signed[:change] == "0"
                    @tasks = current_team.tasks.order(updated_at: :asc).paginate(page: params[:page])
            else
                    @tasks = current_team.tasks.where(to:current_user.id).order(updated_at: :asc).paginate(page: params[:page])
            end
        end
        
    end

    def confirm
    end

    def goals
        
    end

    private
        def store_team
            unless !session[:team_id].nil?
                flash[:danger] = '目標を表示するチームを選んでください'
                redirect_to root_path
            end
        end
    
end
