Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Set the homepage route
  root 'homepages#index'
  
  resources :works 
    
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  # get "/users/current", to: "users#current", as: "current_user"
  # current method redirects to user_path so this route and view can be reused for link_to on "show all users" method 
  get "/users/:id", to: "users#show", as: "user" 

  # work GET    /works/:id(.:format)                                                                     works#show


# need votes routes

end
