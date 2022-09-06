class Photo < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :photo_comments, dependent: :destroy
  has_many :photo_tags, dependent: :destroy, foreign_key: 'photo_id'
  has_many :tags, through: :photo_tags
  has_many :notifications, dependent: :destroy

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
    end
  end

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}

  def create_notification_favorite!(current_user)
	  # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and photo_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        photo_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.is_checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PhotoComment.select(:user_id).where(photo_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      photo_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end


end
