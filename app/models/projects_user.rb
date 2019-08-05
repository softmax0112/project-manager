# frozen_string_literal: true

class Projects_User < ApplicationRecord
  belongs_to :projects
  belongs_to :users
end
