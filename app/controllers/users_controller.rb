class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to root_path unless user_signed_in?
  end

  def edit
    @user = User.find_by(email: current_user.email)
  end
end
