class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_path
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      if cookies.permanent.signed[:change]
        cookies.permanent.signed[:change] = "0"
      end
      redirect_back_or root_path
    else
      flash.now[:danger] = 'Email or password are different'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
