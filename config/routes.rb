Rails.application.routes.draw do
  root to: "homepages#index"
  get "/homepages", to: "homepages#index"

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

  post "/upvote", to: "votes#create", as: "upvote"
  post "/upvote_error", to: "votes#not_logged_in_error", as: "vote_error"

  resources :users
  resources :works
  resources :votes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # The syntax for generating the seven conventional RESTful routes for a given controller are:
  # resources _a symbol of the name of the controller_

end
