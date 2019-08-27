# frozen_string_literal: true

class Api::V1::CommentsController < Api::V1::ApiController
  before_action :set_comment, only: %i[show]
  before_action :fetch_commentable, only: :index

  def index
    @comments = Comment.fetch_commentable_comments(@id, @type).includes(:commenter).page(params[:page])
    success(get_json(@comments))
  end

  def show
    success(get_json(@comment))
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def get_json(comments)
    CommentSerializer.new(comments).serialized_json
  end

  def fetch_commentable
    if params[:payment_id]
      @type = 'Payment'
      @id = params[:payment_id]
    elsif params[:time_log_id]
      @type = 'TimeLog'
      @id = params[:time_log_id]
    else
      @type = 'Project'
      @id = params[:project_id]
    end
  end
end
