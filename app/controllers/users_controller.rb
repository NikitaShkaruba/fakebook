class UsersController < ApplicationController
  def index
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'index'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

private
  def user_params
    params.require(:user).permit(:name, :surname, :password, :mail)
  end
end
