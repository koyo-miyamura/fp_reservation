Rails.application.routes.draw do

  root  'static_pages#home'
  get   '/users/signup',  to: 'users#new'
  post  '/users/signup',  to: 'users#create'
  get   '/fps/signup',    to: 'fps#new'
  post  '/fps/signup',    to: 'fps#create'
  resources :users
  resources :fps
end
