Rails.application.routes.draw do
  resources :works do
    resources :votes, only: [:index, :new]
  end

  resources :users, except: [:destroy, :update, :edit] do
    resources :votes, only: [:index, :new]
  end
  
  #get "/users/:id", to: "users#show", as: "user"
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  # get "/users/current", to: "users#current", as: "current_user"

  root 'homepages#index'
  get '/homepages', to: 'homepages#index', as: 'homepages'

  post '/votes', to: 'votes#create' , as: 'upvote'

end
