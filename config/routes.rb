Rails.application.routes.draw do
  resources :user_sessions, :except => [:index]
  resources :users
  resources :beats do
    resources :likes, :stems, only: [:create, :destroy]
  end

  get 'login' => 'user_sessions#new', :as => :login
  get 'register' => 'users#new', :as => :register
  post 'logout' => 'user_sessions#destroy', :as => :logout
  root 'user_sessions#new'
end
