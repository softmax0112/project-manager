# frozen_string_literal: true

class AttachmentsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @attachments = Attachment.search(params[:filename], @project).page(params[:page])

    respond_to do |format|
      format.js
    end
  end

  def new
    @attachment = Attachment.new

    respond_to do |format|
      format.js
    end
  end

  def create
    @attachment = Attachment.new(attachment_params)

    respond_to do |format|
      if @attachment.save
        format.js
      else
        format.js do
          @attachment.errors.any?
          @attachment.errors.each do |key, value|
          end
        end
      end
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @project_id = @attachment.project_id
    @attachment.destroy

    redirect_to decide_project_path(@project_id), notice: 'Attachment successfully deleted'
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  def attachment_params
    params.require(:attachment).permit(:filename, :project_id)
  end
end
