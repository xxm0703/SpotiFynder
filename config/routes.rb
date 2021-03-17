Rails.application.routes.draw do
  resources :users
  root "users#index"
  get '/auth/spotify/callback', to: 'users#spotify'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
