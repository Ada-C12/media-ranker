Rails.application.routes.draw do
  root "homepages#index"

  resources :works

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  get "/users", to: "users#index", as: "users"
  get "/users/:id", to: "users#show", as: "user"
  post "/works/:id/upvote", to: "votes#upvote", as: "upvote"
end
