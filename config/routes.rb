Rails.application.routes.draw do
  root 'works#main'
  
  get "/works/main", to: "works#main", as: :main
  resources :works
end
