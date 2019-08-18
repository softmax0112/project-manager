# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit

  rescue_from Pundit::NotAuthorizedError do |_exception|
    redirect_to home_path, alert: 'You can not access this namespace or action'
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(_resource_or_scope)
    home_path
  end

  def show_error_page
    render '404'
  end

  def home_path
    return admin_user_path(current_user) if current_user.admin?
    return user_path(current_user) if current_user.user?
    return manager_user_path(current_user) if current_user.manager?
  end

  def decide_project_path(project)
    return project_path(project) unless current_user.manager? || current_user.admin?

    current_user.admin? ? admin_admin_project_path(project) : manager_manager_project_path(project)
  end

  def decide_payment_path(payment)
    return payment_path(payment) unless current_user.manager? || current_user.admin?

    current_user.admin? ? admin_payment_path(payment) : manager_payment_path(payment)
  end

  def decide_time_log_path(time_log)
    return time_log_path(time_log) unless current_user.manager? || current_user.admin?

    current_user.admin? ? admin_time_log_path(time_log) : manager_time_log_path(time_log)
  end

  def decide_payment_path_with_project(payment, project_id)
    current_user.admin? ? admin_payment_path(payment, project_id: project_id) : manager_payment_path(payment, project_id: project_id)
  end

  protected

  def configure_permitted_parameters
    permitted_params = %i[name password enabled image email role]
    devise_parameter_sanitizer.permit(:account_update, keys: permitted_params)
    devise_parameter_sanitizer.permit(:sign_up, keys: permitted_params)
  end
end
