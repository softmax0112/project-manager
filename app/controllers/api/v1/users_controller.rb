# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::ApiController
  before_action :set_user, only: %i[show]

  def index
    @users = User.search(params[:search], @current_user).includes(:time_logs, :projects, :comments).page(params[:page])
    success(get_json(@users))
  end

  def show
    success(get_json(@user))
  end

  def update_profile
    if @current_user.update(user_params)
      success('Information successfully updated!')
    else
      failure(@current_user.errors)
    end
  end

  def myself
    success(get_json(@current_user))
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def get_json(users)
    UserSerializer.new(users).serialized_json
  end

  def user_params
    params.require(:user).permit(:email, :name, :image)
  end
end
