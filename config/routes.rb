# frozen_string_literal: true

Rails.application.routes.draw do
  resources :attachments, only: %i[index create destroy]
  resources :time_logs
  resources :payments, only: %i[show edit create update destroy]
  resources :projects, only: %i[index show]
  resources :clients, only: %i[index show]
  resources :comments, only: %i[index create destroy]

  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :clients, only: %i[index show update create destroy]
      resources :users, only: %i[index show] do
        collection do
          patch 'update_profile'
        end
        collection do
          get 'myself'
        end
      end
      post 'auth/login', to: 'authentication#login'
      resources :projects, only: %i[index show update create destroy] do
        resources :attachments, only: %i[index show]
        resources :time_logs, only: %i[index show] do
          resources :comments, only: %i[index show]
        end
        resources :payments, only: %i[index show] do
          resources :comments, only: %i[index show]
        end
        resources :comments, only: %[index show]
      end
    end
  end

  namespace :admin do
    resources :admin_projects
    resources :payments, only: %i[show edit create update destroy]
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
    resources :payments, only: %i[show edit create update destroy]
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
