Rails.application.routes.draw do
  root 'homepages#index'
  get '/homepages', to: 'homepages#index', as: 'homepages'
  
  resources :works, except: [:update]
  patch '/works/:id', to: 'works#update'
  
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  # get "/users/current", to: "users#current", as: "current_user"
  get 'users', to: 'users#index', as: 'users'
  get '/users/:id', to: 'users#show', as: 'user'
  
  # post '/works/:id/upvote', to: 'votes#upvote', as: 'upvote'
  # Tiff this needs to be a nested route for votes through works
end
