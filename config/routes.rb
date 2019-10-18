Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'homepages#index'
  
  
  resources :works do 
    resources :votes, only: [:create]
    end
    
    resources :users do
      resources :votes, only: [:create] 
    end
    
    resources :votes
    
    post "/login", to: "users#login", as: "login"
    post "/logout", to: "users#logout", as: "logout"
    get "/users/current", to: "users#current", as: "current_user"
    
  end
  