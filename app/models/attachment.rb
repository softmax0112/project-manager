class Attachment < ApplicationRecord
  belongs_to :projects
  mount_uploader :filename, ImageUploader
end
