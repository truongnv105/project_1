Rails.application.routes.draw do
  namespace :admins do
    get '/dashboards', to: 'dashboards#index'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    resources :users, except: %i[new create]
  end

  root 'static_pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations' }
  namespace :users do
    resources :providers, only: %i[create destroy]
  end
end
