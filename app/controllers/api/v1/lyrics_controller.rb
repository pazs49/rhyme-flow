class Api::V1::LyricsController < ApplicationController
  before_action :authenticate_devise_api_token!
  skip_before_action :authenticate_devise_api_token!, only: [ :dummy, :empty ]

  def index
    @lyrics = Lyric.all
    render json: @lyrics
  end

  def empty
    @lyric = Lyric.new
    render json: @lyric
  end

  def dummy
    dummy_lyrics = {
      title: "Love in the Rain",
      body: "Walking alone in the pouring rain\nThinking of you again\nYour smile, your touch, your sweet refrain\nKeeps echoing in my brain",
      genre: "Pop",
      mood: "Romantic",
      public: true,
      likes: 42,
      user_id: 1,
      user_specific_prompts: "Write a love song inspired by rainy nights."
    }

    render json: dummy_lyrics
  end
end
