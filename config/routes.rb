Rails.application.routes.draw do
  resources :todos do
    member do
      patch :move
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users
  root to: "dishes#index"

  resources :dishes, only: [:index, :show] do
    resources :ranks, only: [:create, :update]
  end
  resources :restaurants, only: [:show]
  get "top", to: "categories#top"
  # resources :categories, only: [:top]
  # resources :categories do
  #   member do
  #     get :top
  #   end
  # end
  resources :users, only: [:new, :edit, :update, :show]
  get "show", to: "ranks#show"
end
