# frozen_string_literal: true

class Projects_User < ApplicationRecord
  belongs_to :projects, class_name: 'Project', optional: true
  belongs_to :users, class_name: 'User', optional: true
end
