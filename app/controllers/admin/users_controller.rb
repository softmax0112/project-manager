# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[edit update toggle destroy]

  def index
    @users = User.search(params[:name], current_user.id).page(params[:page])
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      redirect_to home_path, notice: 'User succesfully created'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to home_path, notice: 'User succesfully updated'
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to home_path, notice: 'User succesfully deleted'
  end

  def toggle
    @user.update(enabled: !@user.enabled)

    flash[:notice] = @user.toggle_message
    redirect_to home_path
  end

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :role, :image)
  end
end
