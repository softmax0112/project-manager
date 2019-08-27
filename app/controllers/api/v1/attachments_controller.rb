# frozen_string_literal: true

class Api::V1::AttachmentsController < Api::V1::ApiController
  before_action :set_attachment, only: %i[show]

  def index
    @attachments = Attachment.fetch_project_attachments(params[:search], params[:project_id]).includes(:project).page(params[:page])
    success(get_json(@attachments))
  end

  def show
    success(get_json(@attachment))
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  def get_json(attachments)
    AttachmentSerializer.new(attachments).serialized_json
  end
end
