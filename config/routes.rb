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

  resources :collaboration_requests, only: [:create, :destroy, :update]
  resources :password_resets
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  get 'collaborations' => 'collaboration_requests#index', :as => :collaborations
  get 'feed' => 'beats#index', :as => :feed
end
