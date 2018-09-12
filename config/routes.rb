Rails.application.routes.draw do

  root  'static_pages#home'

  get   '/users/signup',  to: 'users#new'
  post  '/users/signup',  to: 'users#create'
  get   '/fps/signup',    to: 'fps#new'
  post  '/fps/signup',    to: 'fps#create'

  get    'users/login',   to: 'sessions#user_new'
  post   'users/login',   to: 'sessions#user_create'
  get    'fps/login',     to: 'sessions#fp_new'
  post   'fps/login',     to: 'sessions#fp_create'
  delete '/logout',       to: 'sessions#destroy'

  resources :fps, except: [:index, :new, :create] do
    resources :fp_reservable_times, only: [:new, :create, :destroy]
  end
  resources :users, except: [:index, :new, :create] do
    resources :reservations, only: [:new, :create, :destroy]
  end
end
