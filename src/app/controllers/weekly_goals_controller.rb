class WeeklyGoalsController < ApplicationController
    def store
        session[:date] = params[:date]
        redirect_to (weekly_create_or_edit?(session[:date]) ? weekly_goals_path : new_weekly_goal_path)
    end

    def new
        @goals_form = WeeklyGoalsForm.new()      
    end

    def create
        @goals_form = WeeklyGoalsForm.new(goals_params,date_params) 
        if @goals_form.save
            session[:week] = @goals_form.week
            session[:whose] = @goals_form.whose
            redirect_to weekly_goals_path
        else
            flash.now[:danger] = 'plan/actionの入力に誤りがあります'
            render :new
        end
    end

    def index
        if session[:week] && session[:whose]
            @goals = stored_team.weekly_goals.where(month:stored_date,week:session[:week],whose:session[:whose]).order(updated_at: :desc)
        elsif session[:week]
            @goals = stored_team.weekly_goals.where(month:stored_date,week:session[:week]).order(updated_at: :desc)
        elsif session[:whose]
            @goals = stored_team.weekly_goals.where(month:stored_date,whose:session[:whose]).order(updated_at: :desc)
        else
            session[:week] = default_week(stored_team,stored_date)
            session[:whose] = default_whose(stored_team,stored_date)
            @goals = stored_team.weekly_goals.where(month:stored_date,week:session[:week],whose:session[:whose]).order(updated_at: :desc)
        end
        
    end

    def week
        session[:week]  = params[:week]
        redirect_to weekly_goals_path
    end

    def whose
        session[:whose]  = params[:whose]
        redirect_to weekly_goals_path
    end

    def edit
        @weekly_goal = WeeklyGoal.find(params[:id])
    end

    def update
        @weekly_goal = WeeklyGoal.find(params[:id])
        if @weekly_goal.update(edit_goals_params)
            flash[:success] = " Weekly Goal updated"
            redirect_to weekly_goals_path
        else
            render 'edit'
        end
    end

    def destroy
        WeeklyGoal.find(params[:id]).destroy
        flash[:success] = "WeeklyGoal deleted"
        @weekly_goal = stored_team.weekly_goals.where(month:stored_date)
        redirect_to (@weekly_goal.exists? ? weekly_goals_path : goals_path)
    end

    private
        def goals_params
            params.require(:goals)
        end

        def date_params
            params.require(:weekly_goals_form)
        end

        def edit_goals_params
            params.require(:weekly_goal).permit(:team_id,:month,:week,:whose,:plan,:action,:output,:review)
        end
end
