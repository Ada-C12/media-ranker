Rails.application.routes.draw do
  root 'homepages#index'
  get '/homepages', to: 'homepages#index', as: 'homepages'
  
  resources :works, except: [:update]
  patch '/works/:id', to: 'works#update'
end
