Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'works#main'
  post 'works/:id/upvote', to: 'works#upvote', as: 'upvote_work'
  resources :works
end
