class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :photos
  has_many :favorites, dependent: :destroy
  has_many :photo_comments, dependent: :destroy

  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :followed, source: :follower

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :follower, source: :followed

  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  validates :name, presence: true
  validates :nickname, presence: true

  has_one_attached :profile_image



   # ユーザーをフォローする
  def follow(user_id)
   follower.create(followed_id: user_id)
  end
   # ユーザーのフォローを外す
  def unfollow(user_id)
   follower.find_by(followed_id: user_id).destroy
  end
   # フォロー確認をおこなう
  def following?(user)
   followings.include?(user)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "partial_match"
      @user = User.where("nickname LIKE?","%#{word}%")
    end
  end

  #フォロー通知
  def create_notification_follow!(current_user)
   #すでにフォローされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    #フォローされていない場合通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end


end
