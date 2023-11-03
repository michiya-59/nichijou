# frozen_string_literal: true

Rails.application.routes.draw do
  root "homes#index"
  get "/about", to: "homes#about"
  resources :articles, only: %i(index show)

  resources :admin_posts do
    post "upload_content_image", on: :collection
  end
  resources :admin_categories, only: %i(index new create edit update destroy)
  resources :admin_areas, only: %i(index new create edit update destroy)
  resources :admin_stores
  resources :admin_notices

  get "admin/login", to: "admin_sessions#new", as: :admin_login
  post "admin/login", to: "admin_sessions#create"
  get "admin/logout", to: "admin_sessions#destroy", as: :admin_logout
end
