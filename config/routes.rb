Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"

  resources :posts do
    collection do
      get 'search'
    end
    resources :comments, only: :create
    post 'add' => 'favorites#create'
    delete '/add' => 'favorites#destroy'
  end

  
  resources :users, only: [:new, :edit, :update, :show] do
    resource :favorites, on: :collection
  end

  resources :relationships, only: [:create, :destroy]
  
end
