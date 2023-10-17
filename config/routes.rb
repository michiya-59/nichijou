# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :areas, only: [:index, :new, :create, :edit, :update, :destroy]

  get 'admin/login', to: 'admin_sessions#new', as: :admin_login
  post 'admin/login', to: 'admin_sessions#create'
  get 'admin/logout', to: 'admin_sessions#destroy', as: :admin_logout
end
