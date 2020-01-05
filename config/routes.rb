Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Set the homepage route
  root 'homepages#index'
  
  resources :works 
  
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/:id", to: "users#show", as: "user"
  get "/users", to: "users#index", as: "users"

  post "/works/:id/upvote", to: "votes#create", as: "upvote" 
  
end
