# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.admin?
        redirect_to admin_user_path(current_user)
      else
        redirect_to base_user_path(current_user)
      end
    end
  end
end
