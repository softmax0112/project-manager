class Attachment < ApplicationRecord
  belongs_to :projects, optional: true
  mount_uploader :filename, ImageUploader
end
