Rails.application.routes.draw do
  root 'homepages#index'
  resources :homepages
  resources :works
  resources :votes
  resources :users
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
