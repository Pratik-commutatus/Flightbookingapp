Rails.application.routes.draw do

  resources :tickets
  get '/flights/search', to: 'flights#search'
  post '/flights/search', to: 'flights#search'
  resources :flights
  resources :aeroplanes
  root to: 'flights#search'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
