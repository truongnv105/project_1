Rails.application.routes.draw do
  namespace :admin do
    get "/dashboards", to: "dashboards#index"
  end

  root "static_pages#home"
  devise_for :users
end
