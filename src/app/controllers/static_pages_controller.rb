class StaticPagesController < ApplicationController
    before_action :logged_in_user

    def home
        store_location
        @user = current_user
        @tasks = @user.tasks.order(updated_at: :asc).paginate(page: params[:page])
    end
end
