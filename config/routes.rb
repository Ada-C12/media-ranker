Rails.application.routes.draw do
  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout', as: 'logout'
  get 'users/show', to: 'users#show', as: 'user'
  
  root 'works#main'
  post 'works/:id/upvote', to: 'works#upvote', as: 'upvote_work'
  resources :works
end
