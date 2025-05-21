class Like < ApplicationRecord
  belongs_to :user
  belongs_to :lyric

  validates :user_id, uniqueness: { scope: :lyric_id }
end
