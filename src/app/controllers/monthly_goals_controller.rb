class MonthlyGoalsController < ApplicationController
    before_action :logged_in_user
    before_action :group_member, except:[:change]

    def change
        session[:team_id] = params[:team_id]
        redirect_to controller: :static_pages,action: :goals
    end

    def store
        session[:date] = params[:date]
        redirect_to (monthly_create_or_edit?(session[:date]) ? monthly_goals_path : new_monthly_goal_path)
    end

    def new
        @goals_form = MonthlyGoalsForm.new()
            
    end

    def create
        @goals_form = MonthlyGoalsForm.new(goals_params)
        if @goals_form.save
            redirect_to monthly_goals_path
        else
            flash.now[:danger] = 'plan/actionの入力に誤りがあります'
            render :new
        end
    end

    def index
        @goals = stored_team.monthly_goals.where(month:stored_date).order(updated_at: :asc)
    end

    def update
        @goal = MonthlyGoal.find(params[:id])
        if @goal.update(edti_goals_params)
          flash[:success] = "monthly goal updated"
          redirect_to monthly_goals_path
        else
          render 'index'
        end
    end

    def destroy
        @goal.destroy
        flash[:success] = "monthly goal deleted"
        redirect_to monthly_goals_path
    end

    private
        def goals_params
            params.require(:goals)
        end

        def edti_goals_params
            params.require(:monthly_goal).permit(:plan,:action,:output,:review)
        end

        def group_member
            group = Group.find_by(id:stored_team.group_id)
            unless group.members.exists?(id:current_user)
                flash[danger] = "このグループには所属していません"
                redirect_to root_path  
            end
        end
end
