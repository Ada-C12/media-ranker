Rails.application.routes.draw do
  root to: 'works#home'
  resources :works
  resources :users, only: [:index, :show]
  post '/works/:id/upvote', to: 'works#upvote', as: 'upvote_work'
  # get "/login", to: "users#login_form", as: "login"
  # post "/login", to: "users#login"
  # post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#create"
  delete "/logout", to: "users#destroy", as: "logout"
end
