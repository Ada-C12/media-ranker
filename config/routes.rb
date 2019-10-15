Rails.application.routes.draw do
  root 'homepages#index'
  get '/homepages', to: 'homepages#index', as: 'homepages'
  
  resources :works, except: [:update]
  patch '/works/:id', to: 'works#update'
  
  # post '/works/:id/upvote', to: 'votes#upvote', as: 'upvote'
  # Tiff this needs to be a nested route for votes through works
end
