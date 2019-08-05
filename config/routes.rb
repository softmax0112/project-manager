# frozen_string_literal: true

Rails.application.routes.draw do
  resources :attachments
  resources :time_logs
  resources :payments
  resources :projects
  resources :clients

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :admin_projects
    resources :payments
    resources :clients
    resources :time_logs
    resources :users do
      member do
        put :toggle
      end
    end
  end

  namespace :manager do
    resources :manager_projects
    resources :payments
    resources :clients
    resources :time_logs
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
  get '*path', controller: 'application', action: 'show_error_page'
end
