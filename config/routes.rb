Rails.application.routes.draw do
  resources :follows
  # devise_for :users, :controllers => { registrations: 'registrations' }
  devise_for :users, :controllers => {registrations: 'registrations'}
  resources :tweets
  # post '/users/:id/follow', to: "users#follow", as: "follow_user"
  # post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"


  root "tweets#index"
 
end
