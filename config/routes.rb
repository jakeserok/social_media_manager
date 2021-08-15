# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'about', to: 'about#index'

  # social media manager password routes
  get 'password', to: 'passwords#edit', as: :edit_password
  patch 'password', to: 'passwords#update'

  # social media manager sign up routes
  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'

  # social media manager log in routes
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'

  # log out route
  delete 'logout', to: 'sessions#destroy'

  # social media manager password reset routes
  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#create'
  get 'password/reset/edit', to: 'password_resets#edit'
  patch 'password/reset/edit', to: 'password_resets#update'

  # twitter
  get '/auth/twitter/callback', to: 'omniauth_callbacks#twitter'

  # google_oauth2
  get '/google_sign_in/callback', to: 'sessions#omniauth'
  get '/auth/:provider/callback', to: 'sessions#omniauth'

  resources :twitter_accounts
  resources :tweets

  root to: 'home#index'
end
