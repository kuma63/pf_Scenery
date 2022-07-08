class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :photos
  has_many :favorites, dependent: :destroy
  has_many :photo_comments, dependent: :destroy

  has_one_attached :profile_image
  
  def self.guest
    # ユーザがなければ作成あれば取り出す
    find_or_create_by!(email: 'zzz@zzz') do |user|
     user.password = SecureRandom.urlsafe_base64
     user.password_confirmation = user.password
     user.name = 'ゲスト'
     user.nickname = 'ゲスト'
    end 
  end
  



end
