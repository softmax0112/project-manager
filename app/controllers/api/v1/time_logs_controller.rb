# frozen_string_literal: true

class Api::V1::TimeLogsController < Api::V1::ApiController
  before_action :set_time_log, only: %i[show]

  def index
    @time_logs = TimeLog.fetch_project_logs(params[:project_id]).includes(:comments, :project, :user).page(params[:page])
    success(get_json(@time_logs))
  end

  def show
    success(get_json(@time_log))
  end

  private

  def set_time_log
    @time_log = TimeLog.find(params[:id])
  end

  def get_json(time_logs)
    TimeLogSerializer.new(time_logs).serialized_json
  end
end
