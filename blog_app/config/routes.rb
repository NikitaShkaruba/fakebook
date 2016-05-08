Rails.application.routes.draw do
  resources  :articles do
    resources :comments
  end

  get 'welcome/index'
  root 'welcome#index'
end
