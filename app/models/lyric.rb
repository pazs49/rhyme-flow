class Lyric < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  scope :trashed, -> { where(trashed: true) }
  scope :not_trashed, -> { where(trashed: [ false, nil ]) }
end
