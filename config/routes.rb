Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'
  resources :works
  resources :users, only: [:index, :new, :create, :show]

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/user/current", to: "users#current", as: "current_user"
   
  resources :users, only: [:show] do
    resources :votes, only: [:create]
  end

end
