Rails.application.routes.draw do
  get '/search', to: 'videos#search', as: 'search_page'
  get 'home/index'
  get 'videos/new'
  get 'videos/index'
  get 'videos/show'
  post 'videos/create'
  resources :videos
  resources :channels, only: [:index, :create, :destroy]
  root 'videos#index'
  devise_for :users
end
