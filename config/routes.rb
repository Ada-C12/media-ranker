Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'
  
  resources :works
  # resources :homepages
  # resources :votes
  # resources :users
end
