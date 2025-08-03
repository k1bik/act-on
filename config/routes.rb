Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"

  resources :locations, only: %i[new create edit update] do
    member do
      get :cancel_editing
    end

    resources :products do
      member do
        get :edit_name
        get :edit_price
        get :edit_description

        get :cancel_editing_name
        get :cancel_editing_price
        get :cancel_editing_description

        patch :update_name
        patch :update_price
        patch :update_description
      end
    end

    resources :orders
  end
end
