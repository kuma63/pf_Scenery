class PhotosController < ApplicationController
  def index
   if params[:latest]
    @photos = Photo.latest.page(params[:page]).per(6)
   elsif params[:old]
    @photos = Photo.old.page(params[:page]).per(6)
   else
    # いいねが多い順に並び替える
    @photos = Photo.select('photos.*', 'count(favorites.id) AS favs').left_joins(:favorites).group('photos.id').order('favs desc').page(params[:page]).per(6)
   end
   @tag_list = Tag.all
   @photo = Photo.new
   @user = current_user
  end

  def create
   @photo = Photo.new(photo_params)
   @photo.user_id = current_user.id
   tag_list = params[:photo][:name].split(',')

   if @photo.save
    @photo.save_tag(tag_list)
    redirect_to photo_path(@photo.id)
   else
    @photos = Photo.page(params[:page]).per(6)
    @tag_list = Tag.all
    @user = current_user
    render :index
   end

  end

  def show
   @photonew = Photo.new
   @photo = Photo.find(params[:id])
   @user = @photo.user
   @photo_tags = @photo.tags
   @photo_comment = PhotoComment.new
  end

  def photo_map
   @photo = Photo.find(params[:id])
  end

  def edit
   @photo = Photo.find(params[:id])
   @tag_list=@photo.tags.pluck(:name).join(',')
  end

  def update
   @photo = Photo.find(params[:id])
   tag_list = params[:photo][:name].split(',')
   if @photo.update(photo_params)
    @photo.save_tag(tag_list)
    redirect_to photo_path(@photo.id)
   else
    render :edit
   end

  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_path
  end

  def tags_search
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @photos = @tag.photos.page(params[:page]).per(6)
  end

  private

  def tag_list
   params.require(:tag).permit(:name)
  end


  def photo_params
   params.require(:photo).permit(:user_id, :image, :body, :address)
  end

end
