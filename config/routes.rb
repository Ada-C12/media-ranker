Rails.application.routes.draw do
  resources :works do
    resources :votes, only: [:index, :create]
  end

  resources :users, except: [:destroy, :update, :edit] do
    resources :votes, only: [:index, :create]
  end
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"


  root 'homepages#index'
  get '/homepages', to: 'homepages#index', as: 'homepages'

  post '/works/:id/upvote', to: 'works#upvote' , as: 'upvote'
end
