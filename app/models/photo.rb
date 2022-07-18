class Photo < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :photo_comments, dependent: :destroy
  has_many :photo_tags, dependent: :destroy, foreign_key: 'photo_id'
  has_many :tags, through: :photo_tags

  validates :body, presence: true
  validates :image, presence: true
  validates :address, presence: true

  has_one_attached :image

  geocoded_by :address
  after_validation :geocode

  def save_tag(tags)
      # すでにタグ付け登録していた場合、紐付いているタグをすべて削除
      current_tags = self.tags.pluck(:name) unless self.tags.nil?
      old_tags = current_tags - tags
      new_tags = tags - current_tags

    # PhotoTag.transaction do
       # Destroy
       old_tags.each do |old_name|
         self.tags.delete Tag.find_by(name:old_name)
       end
    # end

    # PhotoTag.transaction do
     # Create
     new_tags.each do |new_name|
       photo_tag = Tag.find_or_create_by(name:new_name)
       self.tags << photo_tag
     end
    # end

  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if  search == "partial_match"
      @photo = Photo.where("body LIKE? OR address LIKE?","%#{word}%","%#{word}%")
    end
  end

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}



end
