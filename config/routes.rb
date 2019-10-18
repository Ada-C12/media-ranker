Rails.application.routes.draw do
  
  root to: "homepage#index"
  
  
  resources :votes, :users, :works 
  
end
