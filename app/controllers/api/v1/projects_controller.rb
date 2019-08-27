# frozen_string_literal: true

class Api::V1::ProjectsController < Api::V1::ApiController
  before_action :set_project, only: %i[show update destroy]
  before_action :auth_management, only: %i[create update destroy]

  def index
    @projects = Project.search(params[:search]).includes(:payments, :comments, :time_logs, :attachments, :users, :client, :manager, :creator).page(params[:page])
    success(get_json(@projects))
  end

  def show
    success(get_json(@project))
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      success(get_json(@project), :created)
    else
      failure(@project.errors)
    end
  end

  def update
    if @project.save
      success(get_json(@project))
    else
      failure(@project.errors)
    end
  end

  def destroy
    @project.destroy
    success('Successfully destroyed')
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def get_json(projects)
    ProjectSerializer.new(projects).serialized_json
  end

  def project_params
    params.require(:project).permit(
      :title, :description, :hours_spent, :total_payment, :manager_id, :creator_id, :client_id
    )
  end
end
