Rails.application.routes.draw do
  resources :works
  
  resources :users, except: [:destroy, :update, :edit]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  
  root 'homepages#index'
  get '/homepages', to: 'homepages#index', as: 'homepages'
  
end
