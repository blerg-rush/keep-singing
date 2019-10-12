Rails.application.routes.draw do
  get 'channels/index'
  get 'channels/create'
  get 'channels/destroy'
  get '/search', to: 'videos#search', as: 'search_page'
  get 'home/index'
  get 'videos/new'
  get 'videos/index'
  get 'videos/show'
  post 'videos/create'
  resources :videos
  resources :channels
  root 'videos#index'
  devise_for :users
end
