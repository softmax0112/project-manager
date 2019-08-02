class Admin::PaymentsController < PaymentsController
  before_action :auth_admin
end
