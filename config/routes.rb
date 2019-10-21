Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'homepages#index'
  
  resources :works do
    resources :votes, only: [:create, :destroy]
    # member do
    #   post 'upvote'
    # end
  end
  resources :users 
  # resources :posts do
  #   resources :votes, only: [:create, :destroy]
  # end
  
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  
  
  
  
end
