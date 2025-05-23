class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_devise_api_token!
  before_action :set_current_user

  before_action :set_lyric
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    @comments = @lyric.comments
    render json: @comments
  end

  def show
    render json: @comment
  end

  def create
    @comment = @lyric.comments.build(comment_params)
    @comment.user_id = @current_user.id

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def set_lyric
    @lyric = Lyric.find(params[:lyric_id])
  end

  def set_comment
    @comment = @lyric.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_current_user
    @current_user = current_devise_api_token.resource_owner
  end
end
