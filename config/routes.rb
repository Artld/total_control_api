Rails.application.routes.draw do
  post '/tasks', '/tasks.json', to: "tasks#index"  # for passing filter_by_~ params
  resources :tasks
  resources :users
  resources :admins
  get :token, controller: 'application'
end
