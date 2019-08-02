# frozen_string_literal: true

class TimeLog < ApplicationRecord
  belongs_to :projects, optional: true
end
