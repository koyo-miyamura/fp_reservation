Rails.application.routes.draw do

  root  'static_pages#home'
  delete '/logout',       to: 'sessions#destroy'

  resources :fps, except: [:index, :new, :create] do
    collection do 
      get  'login',  to: 'sessions#fp_new'
      post 'login',  to: 'sessions#fp_create'
      get  'signup', to: 'fps#new'
      post 'signup', to: 'fps#create'
    end
    resources :fp_reservable_times, only: [:new, :create, :destroy]
  end

  resources :users, except: [:index, :new, :create] do
    collection do 
      get  'login',  to: 'sessions#user_new'
      post 'login',  to: 'sessions#user_create'
      get  'signup', to: 'users#new'
      post 'signup', to: 'users#create'
    end
    resources :reservations, only: [:new, :create, :destroy]
  end

end
