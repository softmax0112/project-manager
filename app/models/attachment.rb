class Attachment < ApplicationRecord
  belongs_to :projects
  mount_uploader :image, ImageUploader
end
