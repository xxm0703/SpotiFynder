Rails.application.routes.draw do
  resources :users
  get '/auth/login', to: 'users#login', as: 'login_user'
  get '/auth/logout', to: 'users#logout', as: 'logout_user'
  get '/profile', to: 'users#show', as: 'profile'
  post '/auth/login', to: 'users#authenticate', as: 'auth_user'
  root "users#index"
  get '/auth/spotify/callback', to: 'users#spotify'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
