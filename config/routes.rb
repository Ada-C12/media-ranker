Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "works#index"

  # The syntax for generating the seven conventional RESTful routes for a given controller are:
  # resources _a symbol of the name of the controller_
  resources :works
  resources :users do
    # This is equivelant to only: [:index, :new, :create]
    resources :works, shallow: true
  end
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  

end
