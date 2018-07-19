Rails.application.routes.draw do
  namespace :admin do
    get "/dashboards", to: "dashboards#index"
    resources :users, except: %i(new create)
  end

  root "static_pages#home"
  devise_for :users
end
