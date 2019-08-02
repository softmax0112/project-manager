# frozen_string_literal: true

class Admin::AdminProjectsController < ProjectsController
  before_action :auth_admin
end
