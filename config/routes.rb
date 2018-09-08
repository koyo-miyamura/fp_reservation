Rails.application.routes.draw do

  root 'static_pages#home'
  get  '/users/signup',  to: 'users#new'
  get  '/fps/signup',    to: 'fps#new'
end
