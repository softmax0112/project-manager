# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    @comments = Comment.where('commentable_id = ? AND commentable_type = ?', params[:commentable_id], params[:commentable_type]).order('created_at DESC').page(params[:page])
    respond_to do |format|
      format.html{}
      format.js{}
    end
  end

  def new
    @comment = Comment.new

    respond_to do |format|
      format.html{}
      format.js{}
    end
  end

  def create
    request.params[:comment][:commentable_id] = params[:commentable_id]
    request.params[:comment][:commentable_type] = params[:commentable_type]
    request.params[:comment][:commenter] = current_user.name
    @comment = Comment.new(comment_params)
    respond_to do |format|
      format.html{
        if @comment.save!
          if @comment.commentable_type == 'Project'
            redirect_to decide_project_path(@comment.commentable_id), notice: 'Comment succesfully added'
          elsif @comment.commentable_type == 'Payment'
            redirect_to decide_payment_path_with_project(@comment.commentable_id, params[:project_id]), notice: 'Comment succesfully added'
          else
            redirect_to time_log_path(@comment.commentable_id, project_id: params[:project_id]), notice: 'Comment successfully added'
          end
        else
          render partial: :new
        end
      }
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @type = @comment.commentable_type
    @id = @comment.commentable_id
    @comment.destroy

    respond_to do |format|
      format.html{
        redirect_to comments_path(commentable_id: @id, commentable_type: @type), notice: 'Comment succesfully deleted'
      }
      format.js{}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :commenter, :commentable_type, :commentable_id)
  end
end
