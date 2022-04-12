class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]

  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id])
    @groups = @user.join_groups
  end

  def create
    @user  =User.new(user_params)
    if @user.save
        log_in @user
        flash[:success] = "Welcome to this app!"
        @mytask = @user.join_groups.create(name:'My Task')
        @general = @mytask.teams.create(name:'general')
        @general.members << @user
        remember_group(@mytask)
        remember_team(@general)
        cookies.permanent.signed[:change] = "0"
        render 'static_pages/confirm'
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user) 
    end
end
