class Api::V1::LyricsController < ApplicationController
  before_action :authenticate_devise_api_token!
  before_action :set_current_user

  def index
    @lyrics = Lyric.all
    render json: @lyrics
  end

  def show
    @lyric = @current_user.lyrics.find_by(id: params[:id])
    @lyric ? render(json: @lyric) : render(json: { error: "Lyric not found" }, status: :not_found)
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

  def generate_lyric
    generated_lyrics = LyricGeneratorService.new(params[:user_specific_prompts]).call

    if generated_lyrics
      @lyric = @current_user.lyrics.build(
        title: params[:title],
        genre: params[:genre],
        mood: params[:mood],
        body: generated_lyrics,
        public: params[:public],
        user_specific_prompts: params[:user_specific_prompts]
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
    @lyric = @current_user.lyrics.find_by(id: params[:id])
    return render(json: { error: "Lyric not found" }, status: :not_found) unless @lyric

    if @lyric.update(lyric_params)
      render json: @lyric
    else
      render json: { errors: @lyric.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @lyric = @current_user.lyrics.find_by(id: params[:id])
    return render(json: { error: "Lyric not found" }, status: :not_found) unless @lyric

    @lyric.destroy
    render json: { message: "Lyric deleted successfully" }
  end

  private

  def lyric_params
    params.require(:lyric).permit(:title, :genre, :mood, :body, :public, :user_specific_prompts)
  end

  def set_current_user
    @current_user = current_devise_api_token.resource_owner
  end
end
