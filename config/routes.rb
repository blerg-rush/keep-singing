Rails.application.routes.draw do
  get '/search', to: 'videos#search', as: 'search_page'
  resources :videos, only: [:index, :show, :new, :create]
  resources :channels, only: [:index, :create, :destroy]
  root 'videos#index'
  devise_for :users
end
