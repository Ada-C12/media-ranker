Rails.application.routes.draw do
  resources :works

  resources :users, except: [:destroy, :update, :edit]

  root 'homepages#index'
  get '/homepages', to: 'homepages#index', as: 'homepages'

end
