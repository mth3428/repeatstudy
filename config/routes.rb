Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"

  resources :posts do
    collection do
      get 'search'
    end
    resources :comments, only: :create
    resource :favorites, only: [:create, :destroy]
  end

  
  resources :users, only: [:new, :edit, :update, :show] do
    resource :favorites, on: :collection
  end

end
