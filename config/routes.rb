Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to:"sessions#destroy"

  namespace :admin do
    resources :users
  end
  root to: "tasks#index"
  resources :tasks do
    collection do
      post :confirm_new
    end
    member do
      patch :confirm_edit
    end
  end
end
