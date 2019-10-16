Rails.application.routes.draw do
  root 'homepages#index'
  
  resources :users
  
  resources :works do
    resources :votes, only: [:create]
  end
  
end
