Myflix::Application.routes.draw do
  
  root to: 'users#front'
  get '/register', to: 'users#new'
  get '/home', to: 'videos#index'
  get '/sign_in', to: 'sessions#new'
  # post '/search', to: 'videos#search'
  get 'ui(/:action)', controller: 'ui'

  resources :users, only: [:show,:index,:create]
  resources :videos, except: :destroy do
    collection do
      get '/search', to: 'videos#search'
    end
  end

  resources :categories, only: [:show]



end
