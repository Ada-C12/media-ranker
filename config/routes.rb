Rails.application.routes.draw do
  
  root to: "works#index"
  
  resources :votes
  resources :users
  resources :works 
  
end
