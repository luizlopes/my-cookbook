Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  resources :recipes, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :cuisines, only: [:show, :new, :create, :edit, :update]
  resources :recipe_types, only: [:show, :new, :create, :edit, :update]

  resources :users, only: [] do
    resources :recipes, only: [:index]
  end

  get "/search", to: "home#search"
end
