# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :clients
    resources :users do
      member do
        put :toggle
      end
    end
  end

  namespace :manager do
    resources :clients
    resources :users, only: %i[show edit update destroy]
  end

  resources :users, only: %i[show edit update destroy] do
    member do
      get :change_password
    end
    member do
      patch :update_password
    end
  end

  root to: 'welcome#index'
end
