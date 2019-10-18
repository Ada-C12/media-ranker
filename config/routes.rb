Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepage#index"

  resources :homepages, only: [:index]
  resources :works

  resources :works do
    resources :votes, only: [:index, :new, :create, :update, :destroy] 
  end

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  get "/users", to: "users#index", as: "all_users"
  get "/user/:id", to: "users#show", as: "user"
  

end
