Myflix::Application.routes.draw do
  
  root to: 'videos#index'
  get '/register', to: 'users#new'
  get '/home', to: 'videos#index'
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
