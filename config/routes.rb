Rails.application.routes.draw do
  get 'channels/index'
  get 'channels/create'
  get 'channels/destroy'
  get 'search/new'
  get 'search/show'
  get 'home/index'
  get 'videos/new'
  get 'videos/index'
  get 'videos/show'
  post 'videos/create'
  resources :videos
  resources :channels
  root 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
