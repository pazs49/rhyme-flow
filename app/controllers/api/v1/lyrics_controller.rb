require "net/http"
require "uri"
require "json"

class Api::V1::LyricsController < ApplicationController
  before_action :authenticate_devise_api_token!
  before_action :set_current_user

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
      user_id: 1,
      user_specific_prompts: "Write a love song inspired by rainy nights."
    }

    render json: dummy_lyrics
  end

  def test_api
    url = ENV["DEEPSEEK_BASE_URL"] + "/chat/completions"
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{ENV["DEEPSEEK_API_KEY"]}"
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

  def generate_lyric
    url = ENV["DEEPSEEK_BASE_URL"] + "/chat/completions"
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{ENV["DEEPSEEK_API_KEY"]}"
    }

    user_prompt = params[:user_specific_prompts].presence || "Write song lyrics."

    messages = [
      { role: "system", content: "You are a helpful songwriter." },
      { role: "user", content: user_prompt }
    ]

    body = {
      model: "deepseek-chat",
      messages: messages,
      stream: false
    }

    response = http.post(uri.path, body.to_json, headers)
    parsed_response = JSON.parse(response.body)

    if parsed_response["choices"].present?
      generated_lyrics = parsed_response["choices"][0]["message"]["content"]

      @lyric = Lyric.new(
        title: params[:title],
        genre: params[:genre],
        mood: params[:mood],
        body: generated_lyrics,
        public: params[:public],
        user_id: @current_user.id,
        user_specific_prompts: user_prompt
      )

      if @lyric.save
        render json: @lyric, status: :created
      else
        render json: { errors: @lyric.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Failed to generate lyrics" }, status: :bad_gateway
    end
  end

  private

  def set_current_user
    @current_user = current_devise_api_token.resource_owner
  end
end
