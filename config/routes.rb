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

  
  resources :users do
    resource :favorites, on: :collection
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end

  

end
