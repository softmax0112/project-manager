# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit update toggle destroy]

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_permit_params)
    authorize @user

    if @user.save
      redirect_to home_path, notice: 'User succesfully created'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_permit_params)
      redirect_to home_path, notice: 'User succesfully updated'
    else
      render 'edit'
    end
  end

  def show
    @users = if params[:name]
               User.where('name LIKE ?', "%#{params[:name]}%").page(params[:page])
             else
               User.page(params[:page])
             end
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
