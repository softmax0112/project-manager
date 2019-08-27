# frozen_string_literal: true

class TimeLogsController < ApplicationController
  before_action :set_time_log, only: %i[show edit update destroy]

  def index
    @time_logs = current_user.time_logs.includes(:user).page(params[:page])
    authorize @time_logs
  end

  def show
    @comments = @time_log.comments.order('created_at DESC').limit(TimeLog::COMMENTS_PREVIEW_COUNT)
    @comment = Comment.new
  end

  def new
    @time_log = TimeLog.new
    authorize @time_log
  end

  def edit; end

  def create
    @project = Project.find(params[:time_log][:project_id])
    @time_log = TimeLog.new(time_log_params)

    respond_to do |format|
      if @time_log.save
        @project.time_logs << @time_log
        if current_user.user?
          format.html do
            redirect_to decide_projects_path, notice: 'Time successfully logged!'
          end
        else
          format.js
        end
      else
        format.js do
          @time_log.errors.any?
          @time_log.errors.each do |key, value|
          end
        end
      end
    end
  end

  def update
    if @time_log.update(time_log_params)
      redirect_to decide_project_path(@time_log.project_id), notice: 'Time log was successfully updated'
    else
      render action: :edit
    end
  end

  def destroy
    @project = @time_log.project
    @project.time_logs.destroy(params[:id])
    redirect_to decide_project_path(@project.id), notice: 'Time log was successfully destroyed'
  end

  private

  def set_time_log
    @time_log = TimeLog.includes(:comments, :user).find(params[:id])
    authorize @time_log
  end

  def time_log_params
    params.require(:time_log).permit(:project_id, :user_id, :hours)
  end
end
