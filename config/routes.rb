Rails.application.routes.draw do
  resources :user_sessions, :except => [:index]
  resources :users
  resources :collaboration_requests, only: [:create, :destroy, :update]
  resources :beats do
    resources :likes, :stems, only: [:create, :destroy]
  end

  get 'login' => 'user_sessions#new', :as => :login
  get 'register' => 'users#new', :as => :register
  get 'collaborations' => 'collaboration_requests#index', :as => :collaborations
  get 'feed' => 'beats#index', :as => :feed
  post 'logout' => 'user_sessions#destroy', :as => :logout
  root 'user_sessions#new'
end
