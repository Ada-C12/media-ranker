Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :homepages, only: [:index]
  resources :works
  resources :users

end