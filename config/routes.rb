Myflix::Application.routes.draw do
  
  root to: 'videos#index'
  get '/home', to: 'videos#index'
  # post '/search', to: 'videos#search'
  get 'ui(/:action)', controller: 'ui'

  resources :videos, except: :destroy do
    collection do
      get '/search', to: 'videos#search'
    end
  end

  resources :categories, only: [:show]



end
