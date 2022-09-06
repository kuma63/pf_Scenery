class PhotoComment < ApplicationRecord
  belongs_to :user
  belongs_to :photo

  has_many :notifications, dependent: :destroy

  validates :comment, presence: true
end
