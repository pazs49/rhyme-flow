require "net/http"
require "uri"
require "json"

class Api::V1::LyricsController < ApplicationController
  before_action :authenticate_devise_api_token!
  before_action :set_current_user

  def index
    @lyrics = Lyric.where(public: true).includes(:user, :likers, comments: :user)
    render json: @lyrics.as_json(
      include: {
        user: { only: [ :id, :email ] },
        likers: { only: [ :id, :email ] },
        comments: {
          only: [ :id, :body, :created_at ],
          include: {
            user: { only: [ :id, :email ] }
          }
        }
      }
    )
  end

  def user_lyrics
    @lyrics = Lyric.where(user_id: @current_user.id).includes(:user, :likers, comments: :user)
    render json: @lyrics.as_json(
      include: {
        user: { only: [ :id, :email ] },
        likers: { only: [ :id, :email ] },
        comments: {
          only: [ :id, :body, :created_at ],
          include: {
            user: { only: [ :id, :email ] }
          }
        }
      }
    )
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

    user_prompt = "Title: #{params[:lyric][:title]}\nGenre: #{params[:lyric][:genre]}\nMood: #{params[:lyric][:mood]}\nUser Specific Prompts: #{params[:lyric][:user_specific_prompts]}"

    messages = [
      { role: "system", content: "You are a helpful songwriting assistant. When a user provides details, you generate lyrics and return only a JSON object with the keys: title, genre, mood, and lyrics. Do not return anything else and don't change the title, mood, or genre! If there are minor wrong spelling, correct them but never change the title! You can capitalize the first letter of each word of the title but never change the title!" },
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
      generated_lyrics = generated_lyrics.gsub(/\A```json\s*|\s*```\z/, "")
      generated_lyrics = JSON.parse(generated_lyrics)
      # binding.pry
      @lyric = Lyric.new(
        # lyric_params.merge(body: generated_lyrics, user_id: @current_user.id)
        title: generated_lyrics["title"],
        body: generated_lyrics["lyrics"],
        genre: generated_lyrics["genre"],
        mood: generated_lyrics["mood"],
        public: generated_lyrics["public"],
        user_id: @current_user.id
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

  def show
    @lyric = Lyric.find_by(id: params[:id], user_id: @current_user.id)
    if @lyric
      render json: @lyric
    else
      render json: { error: "Lyric not found" }, status: :not_found
    end
  end

  def update
    @lyric = Lyric.find_by(id: params[:id], user_id: @current_user.id)
    if @lyric
      if @lyric.update(lyric_params)
        render json: @lyric
      else
        render json: { errors: @lyric.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Lyric not found" }, status: :not_found
    end
  end

  def destroy
    @lyric = Lyric.find_by(id: params[:id], user_id: @current_user.id)
    if @lyric
      @lyric.destroy
      render json: { message: "Lyric deleted successfully" }
    else
      render json: { error: "Lyric not found" }, status: :not_found
    end
  end

  private

  def lyric_params
    params.require(:lyric).permit(:title, :genre, :mood, :public, :user_specific_prompts)
  end

  def set_current_user
    @current_user = current_devise_api_token.resource_owner
  end
end
