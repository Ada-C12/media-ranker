Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # RESTful routes:
  root to:'homepages#index'
  
  resources :users
  resources :votes
  resources :works
  
  resources :works do
    resources :votes
  end 
  
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
end 

# resources :drivers do
#   resources :trips, only: [:new]
#   patch '/drivers/:id/status', to: 'drivers#mark_online', as: 'mark_online'
#   patch '/drivers/:id/status', to: 'drivers#mark_offline', as: 'mark_offline'
# end 

# resources :passengers do 
#   resources :trips, only: [:create, :edit, :update, :show]
# end

# resources :trips
