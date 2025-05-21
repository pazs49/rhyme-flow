class Comment < ApplicationRecord
  belongs_to :lyric
  belongs_to :user

  validates :body, presence: true
end
