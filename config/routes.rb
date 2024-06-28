Rails.application.routes.draw do
  post 'login', to: 'sessions#create'
  post 'register', to: 'sessions#register'

  resources :menu_items, only: [:index, :destroy, :create]
  resources :orders, only: [:create, :index]
end
