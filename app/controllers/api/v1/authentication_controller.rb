# frozen_string_literal: true

class Api::V1::AuthenticationController < Api::V1::ApiController
  before_action :authorize_request, except: :login

  def login
    @current_user = User.find_by_email(params[:email])
    if @current_user&.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: @current_user.id)
      time = Time.now + 24.hours.to_i
      success({ token: token, exp: time.strftime('%m-%d-%Y %H:%M'), email: @current_user.email })
    else
      failure({ error: 'unauthorized' }, :unauthorized)
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
