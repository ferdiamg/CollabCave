Rails.application.routes.draw do
  resources :user_sessions
  resources :users
  resources :beats
  resources :artists
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  root 'user_sessions#new'
end
