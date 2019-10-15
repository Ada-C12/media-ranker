Rails.application.routes.draw do
  root 'homepages#index'
  get '/homepages', to: 'homepages#index', as: 'homepages'
  
  resources :works, except: [:update]
  patch '/works/:id', to: 'works#update'
  patch '/works/:id/upvote', to: 'works#upvote', as: 'upvote'
end
