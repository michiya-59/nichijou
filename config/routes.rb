# frozen_string_literal: true

Rails.application.routes.draw do
  resources :admin_posts do
    post "upload_content_image", on: :collection
  end
  resources :admin_categories, only: %i(index new create edit update destroy)
  resources :admin_areas, only: %i(index new create edit update destroy)
  resources :admin_stores

  get "admin/login", to: "admin_sessions#new", as: :admin_login
  post "admin/login", to: "admin_sessions#create"
  get "admin/logout", to: "admin_sessions#destroy", as: :admin_logout
end
