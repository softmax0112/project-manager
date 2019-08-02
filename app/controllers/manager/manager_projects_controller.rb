# frozen_string_literal: true

class Manager::ManagerProjectsController < ProjectsController
  before_action :auth_manager
end
