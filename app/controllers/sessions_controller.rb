class SessionsController < ApplicationController
  before_action :not_logged_in_user,  only: :new

  def new
  end

  def create
    user = User.find_by(mail: params[:session][:mail].downcase)

    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        flash[:warning] = 'Account not activated. Email have been already sent. Check your email for the activation link.'
        redirect_to root_path
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def not_logged_in_user
    if logged_in?
      redirect_to user_path(current_user)
    end
  end
end
