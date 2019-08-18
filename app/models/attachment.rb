# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :project
  mount_uploader :filename, FileUploader

  validates :filename, presence: true
  validates :project_id, presence: true

  def self.search(term, project)
    term.present? ? project.attachments.where('title LIKE ?', "%#{term}%") : project.attachments
  end
end
