# frozen_string_literal: true

require "#{Rails.root}/lib/json_web_token.rb"

class Api::V1::ApiController < ActionController::API
  before_action :authorize_request

  rescue_from ActiveRecord::RecordNotFound do
    render json: 'No such record with the specified ID exists', status: :unauthorized
  end

  rescue_from Pundit::NotAuthorizedError do
    render json: 'You are not authorized to perform this action', status: :unauthorized
  end

  def success(json_response, status = :ok)
    render json: json_response, status: status
  end

  def failure(json_response, status = :forbidden)
    render json: json_response, status: status
  end

  def not_found
    render json: { error: 'not_found' }, status: :not_found
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def auth_management
    raise Pundit::NotAuthorizedError unless @current_user.manager? || @current_user.admin?
  end
end
