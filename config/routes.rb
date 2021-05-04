Rails.application.routes.draw do
  root 'sessions#home'



  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'


  delete '/logout' => 'sessions#destroy'


  resources :cities, only: [:new,:index, :show, :create] 
  resources :restaurants, only: [:new,:index, :show, :create] 
  resources :users, only: [:new, :index, :show, :create, :destroy] 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
