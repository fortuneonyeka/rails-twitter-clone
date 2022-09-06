Rails.application.routes.draw do
  resources :follows
  # devise_for :users, :controllers => { registrations: 'registrations' }
  devise_for :users, :controllers => {registrations: 'registrations'}
  resources :tweets


  root "tweets#index"
 
end
