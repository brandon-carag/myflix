Myflix::Application.routes.draw do
  
  root to: 'pages#front'
  get '/home', to: 'videos#index'
  get '/register', to: 'users#new'
  get '/register/:token', to: 'users#new_with_invitation', as: 'register_with_invite'
  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'
  get 'ui(/:action)', controller: 'ui'
  post 'queue_items/update_queue', to: 'queue_items#update_queue'
  post '/play_video', to: 'videos#play_video'

  resources :categories, only: [:show]
  resources :followings, only: [:index,:create,:destroy]
  resources :invitations, only: [:new,:create]
  resources :password_resets, only: [:new,:create,:edit,:update]
  resources :queue_items, only: [:index,:create,:destroy]
  resources :sessions, only: [:create,:destroy]
  resources :users, only: [:show,:index,:create]
  resources :videos, except: :destroy do
    collection do
      get '/search', to: 'videos#search'
    end
    member do
      resources :reviews, only: [:create]
    end
  end

  namespace :admin do
    resources :videos, only: [:new,:create]
  end

end
