# frozen_string_literal: true

Rails.application.routes.draw do
  root "homes#index"
  get "/about", to: "homes#about"
  resources :articles, only: %i(index show)
  resources :categories, only: %i(show)
  resources :areas, only: %i(show)
  resources :notices, only: %i(index show)
  resources :contacts, only: %i(new create)

  resources :admin_posts do
    post "upload_content_image", on: :collection
  end
  resources :admin_categories, only: %i(index new create edit update destroy)
  resources :admin_areas, only: %i(index new create edit update destroy)
  resources :admin_stores
  resources :admin_notices

  delete "admin/logout", to: "admin_sessions#destroy", as: :admin_logout
  get "admin/login", to: "admin_sessions#new", as: :admin_login
  post "admin/login", to: "admin_sessions#create"

  # エラーページ用のルート
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  match "*path", to: "application#render_404", via: :all
end
