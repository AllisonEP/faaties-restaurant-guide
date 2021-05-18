Rails.application.routes.draw do
  root 'sessions#home'
  get '/auth/google_oauth2/callback' => 'sessions#google_login'



  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'


  delete '/logout' => 'sessions#destroy'


  resources :users, only: [:new, :show, :create] 
  resources :restaurants
  resources :cities
  resources :recommendations, except: [:edit, :update]

  resources :cities do 
    resources :restaurants 
  end

  resources :restaurants do
    resources :recommendations, except: [:edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
