# frozen_string_literal: true

class AttachmentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :filename
  belongs_to :project
end
