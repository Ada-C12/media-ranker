Rails.application.routes.draw do
  resources :works, except: [:edit, :update, :destroy]

  resources :users, except: [:destroy, :update, :edit]

  root 'homepages#index'
  get '/homepages', to: 'homepages#index', as: 'homepages'

end
