Rails.application.routes.draw do
  resources :user_sessions, :except => [:index]
  resources :users
  resources :beats do
    resources :likes
  end
  resources :artists
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  root 'user_sessions#new'
end
