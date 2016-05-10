Rails.application.routes.draw do
  root 'people#index'

  get    'signup'  => 'people#index'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :people
end
