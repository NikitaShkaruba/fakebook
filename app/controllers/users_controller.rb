class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_create_params)

    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_update_params)
      flash.now[:success] = 'Profile sucessfully updated!'
      redirect_to @user
    else
      render 'edit'
    end
  end

private
  def user_create_params
    params.require(:user).permit(:name, :surname, :mail, :password)
  end
  def user_update_params
    params.require(:user).permit(:name, :surname, :password, :mail, :date_of_birth,
                                 :city, :phone_number, :gender, :relationship, :profession, :status)
  end
end
