class TasksController < ApplicationController
    before_action :logged_in_user
    before_action :correct_user, only: :destroy

    def index
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

    def new
        @task = current_user.tasks.build
    end

    def create
        @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = 'Task created!'
            redirect_to session[:forwarding_url]
        else
            render 'new'
        end
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
            redirect_to session[:forwarding_url]
        else
            render 'edit'
        end
    end

    def destroy
        @task.destroy
        flash[:success] = "task deleted"
        redirect_to root_url
    end

    def change
        cookies.permanent.signed[:change] = params[:change]
        redirect_to session[:forwarding_url]
    end

    private

        def task_params
            params.require(:task).permit(:title, :deadline, :urgency_importance, :status, :notes, :group_id,:team_id, :to, :from)
        end

        def correct_user
            @task = current_user.tasks.find_by(id: params[:id])
            redirect_to root_url if @task.nil?
        end
end
