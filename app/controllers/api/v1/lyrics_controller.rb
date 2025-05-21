require "net/http"
require "uri"
require "json"

class Api::V1::LyricsController < ApplicationController
  before_action :authenticate_devise_api_token!
  skip_before_action :authenticate_devise_api_token!, only: [ :dummy, :empty, :test_api ]

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

  def test_api
    url = ENV["DEEPSEEK_BASE_URL"]+"/chat/completions"
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{ENV['DEEPSEEK_API_KEY']}"
    }

    body = {
      model: "deepseek-chat",
      messages: [
        { role: "system", content: "You are a helpful songwriter." },
        { role: "user", content: "Please generate lyrics for a song about love." }
      ],
      stream: false
    }

    response = http.post(uri.path, body.to_json, headers)
    render json: response.body
  end
end
