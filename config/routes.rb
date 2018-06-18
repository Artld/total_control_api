Rails.application.routes.draw do
  resources :tasks
  resources :users
  resources :admins
  get :token, controller: 'application'
end
