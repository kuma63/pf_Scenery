class RelationshipsController < ApplicationController

  def create
   @user = User.find(params[:user_id])
   current_user.follow(params[:user_id])
   @user.create_notification_follow!(current_user)
  end

  def destroy
   @user = User.find(params[:user_id])
   current_user.unfollow(params[:user_id])
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).per(5)
  end

 def followers
  @user = User.find(params[:user_id])
  @users = @user.followers.page(params[:page]).per(5)
 end

end
