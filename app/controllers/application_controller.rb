# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_out_path_for(_resource_or_scope)
    welcome_index_path
  end

  protected

  def configure_permitted_parameters
    permitted_params = %i[name password enabled image]
    devise_parameter_sanitizer.permit(:account_update, keys: permitted_params)

    permitted_params << :email
    devise_parameter_sanitizer.permit(:sign_up, keys: permitted_params)
  end
end
