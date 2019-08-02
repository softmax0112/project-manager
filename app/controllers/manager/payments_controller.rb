# frozen_string_literal: true

class Manager::PaymentsController < PaymentsController
  before_action :auth_manager
end
