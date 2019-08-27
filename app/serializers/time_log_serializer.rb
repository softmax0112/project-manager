# frozen_string_literal: true

class TimeLogSerializer
  include FastJsonapi::ObjectSerializer
  attributes :hours

  has_many :comments
  belongs_to :project
  belongs_to :user
end
