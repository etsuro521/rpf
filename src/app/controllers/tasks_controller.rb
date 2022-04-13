class TasksController < ApplicationController
    before_action :logged_in_user
    before_action :my_task_destroy, only: :destroy
    before_action :correct_user, except: [:index,:new,:create,:change]
    before_action :correct_task_group, only: [:show,:edit,:update]

    def index
        store_location
        if my_task?()
            @tasks = current_group.tasks.order(updated_at: :asc).paginate(page: params[:page],per_page: 20)
        else
            if cookies.permanent.signed[:change] == "0"
                @tasks = current_team.tasks.order(updated_at: :asc).paginate(page: params[:page],per_page: 20)
            else
                @tasks = current_team.tasks.where(to:current_user.id).order(updated_at: :asc).paginate(page: params[:page],per_page: 20)
            end
        end
    end

    def new
        @task = current_user.tasks.build
    end

    def show
        @task = Task.find(params[:id])
        render 'edit'
    end

    def create
        @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = 'Task created'
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
        flash[:success] = "Task deleted"
        redirect_to root_url
    end

    def change
        cookies.permanent.signed[:change] = params[:change]
        redirect_to session[:forwarding_url]
    end

    private

        def task_params
            params.require(:task).permit(:title, :deadline, :urgency_importance, :status, :notes, :group_id,:team_id, :to, :from,:updater)
        end

        def my_task_destroy
            @task = current_user.tasks.find_by(id: params[:id])
            redirect_to root_url if @task.nil?
        end

        def correct_user
            task = Task.find_by(id:params[:id])
            group = Group.find_by(id:task.group_id)
            team = Team.find_by(id:task.team_id)
            if !group.members.exists?(current_user.id)
                flash[:danger] = "You don't belong to any group that manages tasks"
                redirect_to root_path
            elsif team.nil? && !team.members.exists?(current_user.id)
                flash[:danger] = "You don't belong to any team that manages tasks"
                redirect_to root_path
            end
            
        end

        def correct_task_group
            task = Task.find_by(id:params[:id])
            group = Group.find_by(id:task.group_id)
            unless group.id == current_group.id
                flash[:danger] = "This task does not belong to the group under management"
                redirect_to current_user
            end
        end
end
