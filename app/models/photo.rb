class Photo < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :photo_comments, dependent: :destroy
  has_many :photo_tags, dependent: :destroy, foreign_key: 'photo_id'
  has_many :tags, through: :photo_tags

  has_one_attached :image

  def save_tag(tag_list)
    # すでにタグ付け登録していた場合、紐付いているタグをすべて削除
     if self.tags != nil
      photo_tags_records = PhotoTag.where(photo_id: self.id)
      photo_tags_records.destroy_all
     end

     # 新しいタグを保存
     tag_list.each do |tag|
      inspected_tag = Tag.where(name: tag).first_or_create
      self.tags << inspected_tag
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
