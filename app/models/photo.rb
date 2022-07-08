class Photo < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :photo_comments, dependent: :destroy

  has_one_attached :image
end
