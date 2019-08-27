# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    @comments = Comment.fetch_commentable_comments(params[:commentable_id], params[:commentable_type]).includes(:commenter).page(params[:page])
    authorize @comments
  end

  def create
    @comment = Comment.new(comment_params)
    authorize @comment

    respond_to do |format|
      if @comment.save
        format.js
      else
        format.js do
          @comment.errors.any?
          @comment.errors.each do |key, value|
          end
        end
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment

    @type = @comment.commentable_type
    @id = @comment.commentable_id
    @comment.destroy

    @path = send('decide_' + @type.underscore.to_s + '_path', @id)
    redirect_to @path, notice: 'Comment successfully deleted'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :commenter_id, :commentable_type, :commentable_id)
  end
end
