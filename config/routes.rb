Rails.application.routes.draw do
  
  root to: "homepage#index"
  
  
  resources :users
  resources :works do
    resources :votes, only: [:create]
  end
  
end
