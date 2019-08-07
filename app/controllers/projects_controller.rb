# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[show edit update destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = if params[:title]
                  Project.where('title LIKE ?', "%#{params[:title]}%").page(params[:page])
                else
                  Project.page(params[:page])
                end
    authorize @projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @time_logs = if current_user.user?
                   TimeLog.where('project_id = ? AND user_id = ?', @project.id, current_user.id).page(params[:page])
                 else
                   TimeLog.where('project_id = ?', @project.id).page(params[:page])
                 end

    @payments = Payment.where('project_id = ?', @project.id).page(params[:page]) unless current_user.user?
    @attachments = Attachment.where('project_id = ?', @project.id).limit(6)
    @comments = Comment.where('commentable_id = ? AND commentable_type = ?', @project.id, 'Project').order('created_at DESC').limit(3)
    authorize @payments unless current_user.user?
  end

  # GET /projects/new
  def new
    @project = Project.new
    authorize @project
  end

  # GET /projects/1/edit
  def edit; end

  # POST /projects
  # POST /projects.json
  def create
    request.params[:project][:creator_id] = current_user.id
    @project = Project.new(project_params)
    authorize @project

    if @project.save
      params[:project][:users_ids].each do |uid|
        Projects_User.create!(user_id: uid, project_id: params[:id]) unless uid.blank?
      end
      redirect_to @project, notice: 'Project was successfully created'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    request.params[:project][:creator_id] = current_user.id

    respond_to do |format|
      if @project.update(project_params)
        format.html do
          params[:project][:users_ids].each do |uid|
            Projects_User.create!(user_id: uid, project_id: params[:id]) unless uid.blank?
          end
          redirect_to @project, notice: 'Project was successfully updated'
        end
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render action: :edit, project_id: params[:project_id] }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:title, :description, :hours_spent, :total_payment,
                                    :manager_id, :creator_id, :client_id)
  end
end
