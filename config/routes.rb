Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'featured#index'
  resources :works
  resources :users
  
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  
  get '/vote/:id', to: 'votes#vote_by_work_id', as: 'vote_by_work_id'
  get '/featured', to: 'featured#index'
  
end
