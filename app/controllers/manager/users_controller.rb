# frozen_string_literal: true

class Manager::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy]

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :image)
  end
end
