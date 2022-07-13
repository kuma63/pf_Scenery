class Photo < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :photo_comments, dependent: :destroy
  has_many :photo_tags, dependent: :destroy, foreign_key: 'photo_id'
  has_many :tags, through: :photo_tags

  has_one_attached :image

  def save_tag(tags)
    # すでにタグ付け登録していた場合、紐付いているタグをすべて削除
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

   # Destroy
   old_tags.each do |old_name|
     self.tags.delete Tag.find_by(name:old_name)
   end

   # Create
   new_tags.each do |new_name|
     photo_tag = Tag.find_or_create_by(name:new_name)
     self.tags << photo_tag
   end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if  search == "partial_match"
      @photo = Photo.where("body LIKE? OR address LIKE?","%#{word}%","%#{word}%")
    else
      @photo = Photo.all
    end
  end
end
