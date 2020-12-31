Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: redirect('/home')
  get '/home', to: 'application#home'

  resources :users, only: [:index, :show]
  resources :events, only: [:index]
  resources :bookings
end
