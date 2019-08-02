# frozen_string_literal: true

class TimeLog < ApplicationRecord
  belongs_to :project
  belongs_to :user
end
