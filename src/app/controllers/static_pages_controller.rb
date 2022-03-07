class StaticPagesController < ApplicationController
    before_action :logged_in_user

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
end
