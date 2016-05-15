class UsersController < ApplicationController
  before_action :logged_in_user,      only: [:edit, :update, :index]
  before_action :correct_user,        only: [:edit, :update]

  def index
    @users = User.all #;paginate(page: params[:page])
  end

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

  # Before filters
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please, log in to access private pages!'
      redirect_to login_path
    end
  end
  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:danger] = 'You cannot edit other users! ;)'
      redirect_to(root_url)
    end
  end
end
