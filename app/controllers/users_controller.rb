# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :shorten_params, only: %i[update update_password]
  before_action :set_user, only: %i[show edit update destroy]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to home_path, notice: 'User successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to home_path, notice: 'Sorry to see you go!'
  end

  def set_user
    @user = User.find(params[:id])
  end

  def shorten_params
    @user_params = params[:user]
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :image)
  end
end
