Myflix::Application.routes.draw do
  
  root to: 'pages#front'
  get '/register', to: 'users#new'
  get '/home', to: 'videos#index'
  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'
  # post '/search', to: 'videos#search'
  get 'ui(/:action)', controller: 'ui'

  resources :users, only: [:show,:index,:create]
  resources :sessions, only: [:create,:destroy]
  resources :videos, except: :destroy do
    collection do
      get '/search', to: 'videos#search'
    end
    member do
      resources :reviews, only: [:create]
    end
  end

  resources :categories, only: [:show]



end
