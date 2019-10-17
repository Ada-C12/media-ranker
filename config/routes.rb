Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'works#top_ten'
  
  get '/works/top_ten', to: 'works#top_ten', as: 'top_ten_works'

  resources :works do
    resources :votes, only: [:index, :post]
  end
  
  resources :users, except: :delete
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"

  # resources :votes, shallow: true
  
end
