Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root to: "home#index"

  namespace :admin do
    resources :products
    resources :categories
  end

  resources :analytics, only: [:index]

  resources :brand, only: [:index]
  resources :carts, only: [:index, :show, :edit, :update, :destroy]
  resources :checkout, only: [:create]

  resources :products, only: [:index, :show]
  resources :product_categories, only: [:index, :show]
  resources :product_subscriptions, only: [:create, :show]
  resources :search, only: [:index]
  resources :reviews, only: [:show, :create]
end