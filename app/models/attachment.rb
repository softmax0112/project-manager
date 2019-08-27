# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :project

  mount_uploader :filename, FileUploader
  validates :filename, presence: true

  def self.fetch_project_attachments(term, project_id)
    project = Project.find(project_id)
    project.attachments.where('filename LIKE ?', "%#{term}%") if term.present?
    project.attachments
  end
end
