# frozen_string_literal: true

class Manager::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def show
    @top_projects = Project.highest_earning
    @bottom_projects = Project.lowest_earning

    @time_log_sorted_projects = Project.sort_by_time_logged_this_month
    @payment_sorted_projects = Project.sort_by_payment_this_month
  end

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :image, :enabled)
  end
end
