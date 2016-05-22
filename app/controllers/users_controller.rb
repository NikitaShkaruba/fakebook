class UsersController < ApplicationController
  before_action :not_logged_in_user,  only: :new
  before_action :logged_in_user,      only: [:edit, :update, :index, :destroy, :following, :followers]
  before_action :correct_user,        only: [:edit, :update]
  before_action :admin_user,          only: :destroy

  def new
    @user = User.new
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    @new_post = current_user.posts.build if logged_in?
  end

  def create
    @user = User.new(user_create_params)

    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account. Mail's arrival time ~ 30 seconds"
      redirect_to root_url
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

  def index
    @users = User.paginate(page: params[:page])
  end

  def following
    @title = 'Following'
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
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
  def not_logged_in_user
    if logged_in?
      redirect_to user_path(current_user)
    end
  end
  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:danger] = 'You cannot edit other users! ;)'
      redirect_to(root_url)
    end
  end
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
