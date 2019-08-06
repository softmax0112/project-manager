# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :projects, optional: true
  mount_uploader :filename, ImageUploader

  validates :filename, presence: true
  validates :project_id, presence: true
end
