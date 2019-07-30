# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    flash[:notice] = 'You are already signed in' if user_signed_in?
    redirect_to home_path if user_signed_in?
  end
end
