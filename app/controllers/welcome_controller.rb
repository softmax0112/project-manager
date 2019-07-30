# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    redirect_to home_path, :notice 'You are already signed in' if user_signed_in?
  end
end
