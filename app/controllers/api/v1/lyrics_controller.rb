class Api::V1::LyricsController < ApplicationController
  before_action :authenticate_devise_api_token!
  before_action :set_current_user
  before_action :set_lyric, only: [ :show, :update, :destroy ]

  def index
    # render json: Lyric.all
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

  def show
    render json: @lyric
  end

  def user_lyrics
    lyrics = @current_user.lyrics.includes(:user, :likers, comments: :user)
    render json: lyrics.as_json(include: {
      user: { only: [ :id, :email ] },
      likers: { only: [ :id, :email ] },
      comments: {
        only: [ :id, :body, :created_at ],
        include: { user: { only: [ :id, :email ] } }
      }
    })
  end

  def empty
    render json: Lyric.new
  end

  def dummy
    render json: {
      title: "Love in the Rain",
      body: "Walking alone in the pouring rain\nThinking of you again\nYour smile, your touch, your sweet refrain\nKeeps echoing in my brain",
      genre: "Pop",
      mood: "Romantic",
      public: true,
      user_id: 1,
      user_specific_prompts: "Write a love song inspired by rainy nights."
    }
  end

  def generate_lyric
    service = LyricGeneratorService.new(
      user_prompt: formatted_user_prompt,
      system_prompt: system_prompt
    )

    generated = service.generate

    if generated
      @lyric = @current_user.lyrics.new(
        title: generated["title"],
        body: generated["lyrics"],
        genre: generated["genre"],
        mood: generated["mood"],
        public: generated["public"],
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

  def update
    if @lyric.update(lyric_params)
      render json: @lyric
    else
      render json: { errors: @lyric.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @lyric.destroy
    render json: { message: "Lyric deleted successfully" }
  end

  private

  def set_current_user
    @current_user = current_devise_api_token.resource_owner
  end

  def set_lyric
    @lyric = @current_user.lyrics.find_by(id: params[:id])
    render json: { error: "Lyric not found" }, status: :not_found unless @lyric
  end

  def lyric_params
    params.require(:lyric).permit(:title, :genre, :mood, :public, :user_specific_prompts)
  end

  def formatted_user_prompt
    lyric = params[:lyric]
    <<~PROMPT.strip
      Title: #{lyric[:title]}
      Genre: #{lyric[:genre]}
      Mood: #{lyric[:mood]}
      Public: #{lyric[:public]}
      User Specific Prompts: #{lyric[:user_specific_prompts]}
    PROMPT
  end

  def system_prompt
    <<~PROMPT.strip
      You are a helpful songwriting assistant. When a user provides details, generate lyrics and return only a JSON object with keys: title, genre, public, mood, and lyrics. Never change the title, mood, or genre. You may correct minor spelling and capitalize the title's words.
    PROMPT
  end
end
