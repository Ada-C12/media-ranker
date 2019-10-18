Rails.application.routes.draw do
  root to: "homepages#index"
  get '/users', to: 'users#index', as: 'users'
  get '/users/:id', to: 'users#show', as: 'user'

resources :works

get "/login", to: "users#login_form", as: "login"
post "/login", to: "users#login"
post "/logout", to: "users#logout", as: "logout"


end
