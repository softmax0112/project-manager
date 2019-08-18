# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.search(params[:title]).page(params[:page])
    authorize @projects
  end

  def show
    @time_logs = TimeLog.search(@project.id, current_user).order('created_at DESC').page(params[:page])

    unless current_user.user?
      @payments = @project.payments.order('created_at DESC').page(params[:page])
      authorize @payments
    end

    @attachments = @project.attachments.order('created_at DESC').limit(Project::ATTACHMENTS_PREVIEW_COUNT)
    @comments = @project.comments.order('created_at DESC').limit(Project::COMMENTS_PREVIEW_COUNT)
    @comment = Comment.new
    @attachment = Attachment.new
    @payment = Payment.new
    @time_log = TimeLog.new
  end

  def new
    @project = Project.new
    authorize @project
  end

  def edit; end

  def create
    @project = Project.new(project_params)
    authorize @project

    @uids_length = params[:project][:users_ids].length
    @project.users = User.find(params[:project][:users_ids].slice(1..@uids_length))

    if @project.save(project_params)
      redirect_to @project, notice: 'Project was successfully created'
    else
      render :new
    end
  end

  def update
    @uids_length = params[:project][:users_ids].length
    @project.users = User.find(params[:project][:users_ids].slice(1..@uids_length))

    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated'
    else
      render action: :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end

  def project_params
    params.require(:project).permit(
      :title, :description, :hours_spent, :total_payment, :manager_id, :creator_id, :client_id
    )
  end
end
