Rails.application.routes.draw do
  root 'works#main'
  
  get "/works/main", to: "works#main", as: :main
  resources :works
  post "/works/:id/upvote", to: "works#upvote", as: "upvote"
  
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/index", to: "users#index", as: "users"
  get "/users/:id", to: "users#show", as: "user"
  
end
