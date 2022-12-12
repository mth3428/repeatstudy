Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"

  resources :posts, only: [:new, :create]
  resources :users, only: [:new, :edit, :update]
end
