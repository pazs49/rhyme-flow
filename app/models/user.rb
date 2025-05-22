class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :api

  has_many :lyrics, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_lyrics, through: :likes, source: :lyric
  has_many :comments, dependent: :destroy
end
