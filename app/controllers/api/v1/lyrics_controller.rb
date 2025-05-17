class Api::V1::LyricsController < ApplicationController
  before_action :authenticate_devise_api_token!

  def index
    @lyrics = Lyrics.all
    render json: @lyrics
  end
end
