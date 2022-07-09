class Tag < ApplicationRecord
  has_many :photo_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :photos, through: :photo_tags

  validates :name, uniqueness: true, presence: true
end
