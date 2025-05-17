class Api::V1::LyricsController < ApplicationController
  before_action :authenticate_devise_api_token!

  def index
    @lyrics = Lyric.all
    render json: @lyrics
  end
end
