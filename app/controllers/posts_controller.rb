class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created!'
    else
      flash[:error] = 'Newly created post cannot be empty!'
    end
    redirect_to :back
  end

  def destroy
    @post.destroy
    flash[:success] = 'Micropost deleted'
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:content, :picture)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_path if @post.nil?
  end
end
