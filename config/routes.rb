Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :lyrics, only: [ :index, :show, :create, :update, :destroy ] do
        collection do
          get :empty
          get :dummy
          get :test_api
          post :generate_lyric
          get :user_lyrics
        end

        member do
          post :like, to: "likes#create"
        end

        resources :comments, only: [ :index, :show, :create, :update, :destroy ]
      end
    end
  end
end
