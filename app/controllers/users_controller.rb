class UsersController < ApplicationController

 def show
  @user = User.find(params[:id])
  @photo = Photo.new
  @photos = @user.photos.page(params[:page]).per(6)
 end

 def edit
  @user = User.find(params[:id])
  if @user == current_user
   render "edit"
  else
   redirect_to photos_path
  end
 end

 def update
  @user = User.find(params[:id])
  if @user.update(user_params)
   redirect_to photos_path
  else
   render :edit
  end

 end


 def favorites
  @user = User.find(params[:id])
  @favorite_photos = Photo.where(id: @user.favorites.pluck(:photo_id)).page(params[:page]).per(6)
 end

 private

 def user_params
  params.require(:user).permit(:profile_image, :name, :nickname, :email, :is_deleted, :is_admin)
 end

end
