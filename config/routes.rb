Rails.application.routes.draw do
  root 'users#index'

  get    'signup'  => 'users#index'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
end
