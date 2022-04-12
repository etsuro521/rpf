class TeamsController < ApplicationController
    before_action :logged_in_user
    before_action :user_has_group, only:[:new,:create,:destroy]
    before_action :user_added_team, except:[:new,:create,:confirm,:destroy]

    def new
        @team = current_group.teams.build
    end

    def create
        @team = current_group.teams.build(team_params)
        if @team.save
            flash[:success] = 'Team created'
            @team.add_first_user(current_user)
            remember_team(@team)
            redirect_to @team
        else
            render 'new'
        end
    end

    def index
        redirect_to root_path
    end

    def show
        store_location
        @team = Team.find(params[:id])
        @members = @team.members
    end

    def change
        team = Team.find(params[:id])
        remember_team(team)
        redirect_to root_path
    end

    def search
        @team = Team.find(params[:id])
        if params[:email].blank?
            @result_users = nil
            return @result_users
        end
        @keywords = params[:email]
        @result_users = current_group.members.where("email like ?","%"+@keywords+"%")
        
    end

    def add
        @team = Team.find(params[:id])
        @user = User.find(params[:user_id])
        @team.add_user(@user)
        redirect_to @team
    end

    def edit
        @team = Team.find(params[:id])
    end

    def update
        @team = Team.find(params[:id])
        if @team.update(team_params)
          flash[:success] = "Team Name updated"
          redirect_to @team
        else
          render 'edit'
        end
    end

    def destroy
        Team.find(params[:id]).destroy
        flash[:success] = 'Team deleted'
        if !current_user.join_teams.empty?
            remember_team(current_user.join_teams.first)
        else
            cookies.delete :team_id
        end
        redirect_to root_path
    end

    def confirm
        store_location
        @team = Team.find(params[:id])
    end

    private
        def team_params
            params.require(:team).permit(:name)
        end

        def user_added_team
            @user_team = current_user.user_teams.find_by(team_id:params[:id])
            if @user_team.nil?
                flash[:danger] = "You don't belong to this team"
                redirect_to root_path  
            end
        end
end
