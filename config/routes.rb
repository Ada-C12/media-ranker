Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "application#home_page"
  
  resources :users
  resources :works
  resources :votes
end
