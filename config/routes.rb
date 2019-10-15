Rails.application.routes.draw do
  get 'votes/index'
  get 'votes/show'
  get 'votes/new'
  get 'votes/create'
  get 'votes/edit'
  get 'votes/update'
  get 'votes/destroy'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  get 'users/edit'
  get 'users/update'
  get 'users/destroy'
  resources :works
  resources :votes
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
