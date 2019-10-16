Rails.application.routes.draw do
  root 'works#main'
  
  get "/works/main", to: "works#main", as: :main
  resources :works
  
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  
end
