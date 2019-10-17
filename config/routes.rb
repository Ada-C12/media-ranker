Rails.application.routes.draw do
  root to: "homepages#index"
  resources :users 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :works

get "/login", to: "users#login_form", as: "login"
post "/login", to: "users#login"
post "/logout", to: "users#logout", as: "logout"
get "/users/current", to: "users#current", as: "current_user"

end
