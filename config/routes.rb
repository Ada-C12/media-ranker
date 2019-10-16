Rails.application.routes.draw do
  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout', as: 'logout'
  get 'users/show', to: 'users#show', as: 'user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'works#main'
  post 'works/:id/upvote', to: 'works#upvote', as: 'upvote_work'
  resources :works
end
