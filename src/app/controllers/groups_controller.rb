class GroupsController < ApplicationController
    before_action :logged_in_user
    before_action :group_admin_user, except:[:new,:create,:change]

    def new
        @group = current_user.join_groups.build
    end
    
    def create
        @group = current_user.join_groups.build(group_params)
        if @group.save
            flash[:success] = 'Group created'
            @group.add_first_user(current_user)
            remember_group(@group)
            @team = @group.teams.create(name:'general')
            @team.members << current_user
            remember_team(@team)
            if first_group?(current_user)
                redirect_to root_path
            else
                redirect_to current_user
            end
        else
            render 'new'
        end
    end    

    def index
        redirect_to root_path
    end

    def edit
        @group = Group.find(params[:id])
    end

    def update
        @group = Group.find(params[:id])
        if @group.update(group_params)
          flash[:success] = "Group Name updated"
          redirect_to @group
        else
          render 'edit'
        end
    end

    def destroy
        @group = Group.find(params[:id])
        if @group.name == "My Task"
            flash[:danger] = 'You cannot delete this group'
        else
            @group.destroy
            flash[:success] = 'Group deleted'
            remember_group(current_user.join_groups.first)
        end
        redirect_to current_user
    end

    def show
        @group = Group.find(params[:id])
        @members = @group.members
    end

    def change
        group = Group.find(params[:group_id])
        remember_group(group)
        remember_team(group.teams.find_by(name:'general'))
        if session[:week] && session[:whose]
            session.delete(:week)
            session.delete(:whose)
        end
        redirect_to root_path
    end

    def search
        @group = Group.find(params[:id])
        if params[:email].blank?
            @result_users = nil
            return @result_users
        end
        @keywords = params[:email]
        @result_users = User.where("email like ?","%"+@keywords+"%")
    end

    def add
        @group = Group.find(params[:id])
        @team = @group.teams.find_by(name:'general')
        @user = User.find(params[:user_id])
        @group.add_user(@user)
        @team.add_user(@user)
        redirect_to @group
    end


    private
        def group_params
            params.require(:group).permit(:name)
        end

        def group_admin_user
            @user_group = current_user.user_groups.find_by(group_id:params[:id])
            admin = @user_group.nil? ? false : @user_group.admin
            unless admin
                flash[:danger] = "You aren't admin user of this group"
                redirect_to current_user 
            end
        end
        
end


