Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users
  root to: "dishes#index"

  resources :dishes, only: [:index, :show]
  resources :restaurants, only: [:show]
  resources :categories do
    member do
      get :top
    end
  end
end
