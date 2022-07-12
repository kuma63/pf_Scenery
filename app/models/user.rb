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

  has_one_attached :profile_image

  def self.guest
    # ユーザがなければ作成,あれば取り出す
    find_or_create_by!(email: 'zzz@zzz') do |user|
     user.password = SecureRandom.urlsafe_base64
     user.password_confirmation = user.password
     user.name = 'ゲスト'
     user.nickname = 'ゲスト'
    end
  end

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




end
