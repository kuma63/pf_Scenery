class PhotosController < ApplicationController
  def index
   @photos = Photo.all
   @tag_list = Tag.all
   @photo = Photo.new
   @user = current_user
  end

  def create
   @photo = Photo.new(photo_params)
   @photo.user_id = current_user.id
   tag_list=params[:photo][:name].split(',')
   if @photo.save
    @photo.save_tag(tag_list)
    redirect_to photos_path
   else
    redirect_to :back
   end

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
