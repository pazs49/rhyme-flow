class Api::V1::LikesController < ApplicationController
  before_action :authenticate_devise_api_token!
  before_action :set_current_user

  def create
    lyric = Lyric.find(params[:id])

    if !lyric.public
      return render json: { error: "You can only like public lyrics." }, status: :forbidden
    end

    existing_like = @current_user.likes.find_by(lyric: lyric)

    if existing_like
      existing_like.destroy
      render json: { message: "Lyric unliked!" }, status: :ok
    else
      like = @current_user.likes.build(lyric: lyric)
      if like.save
        render json: { message: "Lyric liked!" }, status: :created
      else
        render json: { errors: like.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def likes_count
    likes.count
  end

  private

  def set_current_user
    @current_user = current_devise_api_token.resource_owner
  end
end
