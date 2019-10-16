Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "homepages#index"
  get "/homepages/nope", to: "homepages#nope", as: "nope"
  
  get '/users/login', to: "users#login", as: "login"
  patch '/users', to: "users#logout", as: "logout"
  resources :users, only: [:index, :create, :show]
  
  resources :works
  
  # no pages for votes
  post '/votes', to: "votes#create", as: "cast_vote"
end
