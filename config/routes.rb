Rails.application.routes.draw do
  get 'works/index'
  get 'movies/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "homepages#index"
  
  resources :users, only: [:index, :create]
  get '/users/login', to: "users#login", as: "login"
  get '/users/:id', to: "users#show", as: "user"
  
  resources :movies
  
end
