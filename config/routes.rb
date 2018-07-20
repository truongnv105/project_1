Rails.application.routes.draw do
  namespace :admin do
    get "/dashboards", to: "dashboards#index"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :users, except: %i(new create)
  end

  root "static_pages#home"
  get "/auth/:provider/callback", to: "sessions#create"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
    registrations: "users/registrations" }
end
