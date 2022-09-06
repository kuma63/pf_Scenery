class PhotoCommentsController < ApplicationController
   def create
    @photo = Photo.find(params[:photo_id])
    @comment = current_user.photo_comments.new(photo_comment_params)
    @comment.photo_id = @photo.id
    @comment.save
    @photo.create_notification_comment!(current_user, @comment.id)
   end

   def destroy
    PhotoComment.find(params[:id]).destroy
    @photo = Photo.find(params[:photo_id])
   end

  private

  def photo_comment_params
    params.require(:photo_comment).permit(:user_id, :photo_id, :comment)
  end
end
