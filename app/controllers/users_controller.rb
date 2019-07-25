# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to root_path unless user_signed_in?
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @users = User.all
  end

  def toggle
    @user = User.find(params[:id])
    @user.update(enabled: !@user.enabled)

    redirect_to root_path
  end
end
