class PhotosController < ApplicationController
  def index
   @photos = Photo.all
   @photo = Photo.new
   @user = current_user
  end

  def create
  end

  def show
  end

  def photo_map
  end

  def edit
   @photo = Photo.find(params[:id])
  end

  def update
   @photo = Photo.find(params[:id])
   @Photo.update(photo_params)
   redirect_to photos_path
  end

  def destroy
  end

  private

  def photo_params
   params.require(:photo).permit(:user_id, :image, :body, :address)
  end

end
