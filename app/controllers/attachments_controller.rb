# frozen_string_literal: true

class AttachmentsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @attachments = Attachment.where('project_id = ?', @project.id)
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /attachments
  # POST /attachments.json
  def create
    request.params[:attachment][:project_id] = params[:project_id] unless request.params[:attachment].nil?
    request.params[:project_id] = params[:project_id]
    @attachment = Attachment.new(attachment_params)

    respond_to do |format|
      if @attachment.save
        format.html { redirect_to decide_project_path(params[:project_id]), notice: 'Attachment was successfully created' }
        format.json { render :show, status: :created, location: @attachment }
      else
        format.html{ render partial: 'new' }
        format.js{}
      end
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @project_id = @attachment.project_id
    @attachment.destroy

    redirect_to attachments_path(project_id: @project_id), notice: 'Attachment successfully deleted'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def attachment_params
    params.require(:attachment).permit(:filename, :project_id)
  end
end
