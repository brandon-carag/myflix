Myflix::Application.routes.draw do
  
  root to: 'pages#front'
  get '/register', to: 'users#new'
  get '/home', to: 'videos#index'
  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'
  get 'ui(/:action)', controller: 'ui'
  # post 'queue_items/sort_list_order', to: 'queue_items#sort_list_order'
  post 'queue_items/update_queue', to: 'queue_items#update_queue'

  resources :categories, only: [:show]
  resources :followings, only: [:index,:create,:destroy]
  resources :users, only: [:show,:index,:create]
  resources :sessions, only: [:create,:destroy]
  resources :queue_items, only: [:index,:create,:destroy]
  resources :password_resets
  resources :videos, except: :destroy do
    collection do
      get '/search', to: 'videos#search'
    end
    member do
      resources :reviews, only: [:create]
    end
  end

end
