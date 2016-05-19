Rails.application.routes.draw do
  root 'users#new'

  resources :users
  resources :account_activations, only: [:edit]

  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
end
