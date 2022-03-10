class UserGroupsController < ApplicationController
    before_action :logged_in_user
    before_action :admin_user, only:[:update,:destroy]

    def update
        @user_group = UserGroup.find(params[:id])
        @group = Group.find(params[:group_id])
        if params[:admin]=='false' && UserGroup.where("(group_id=?) AND (admin=true)",@group.id).count == 1
            flash[:danger] = "管理者が一人もいなくなります"
            redirect_to @group
        elsif User.find(@user_group.user_id).id == current_user.id
            redirect_to current_user
            @user_group.update(user_group_params)
        else
            @user_group.update(user_group_params)
            redirect_to @group
        end
       
    end

    def destroy
        @user_group = UserGroup.find(params[:id])
        @group = Group.find(@user_group.group_id)
        user_id = @user_group.user_id
        if first_user?(@group)
            flash[:danger] = 'グループにメンバーがいなくなります'
            redirect_to @group
            return
        end

        @user_group.destroy
        UserTeam.find_by(user_id:user_id).destroy
        remember_group(current_user.join_groups.first)
        if User.find(user_id).id == current_user.id
            redirect_to current_user
        else
            redirect_to @group
        end
    end

    private
        def user_group_params
            params.permit(:admin)
        end

        def admin_user
            group_id = UserGroup.find_by(id:params[:id]).group_id
            @user_group = UserGroup.find_by(user_id:current_user.id,group_id:group_id)
            admin = @user_group.nil? ? false : @user_group.admin
            unless admin
                flash[:danger] = 'このグループの管理者ではありません'
                redirect_to current_user 
            end
        end
        
end
