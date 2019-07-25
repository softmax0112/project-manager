# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  get 'users/edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#show'
end
