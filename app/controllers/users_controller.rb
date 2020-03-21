class UsersController < ApplicationController
  before_action :authenticate_user!
  def show   
    @user = User.find(params[:id])
    @posts = Post.with_attached_image.where(user_id: @user).order(created_at: :desc).page(params[:page]).per(12)
  end

  def following
      @user  = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end
end
