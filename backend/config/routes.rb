Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :roles
      resources :statuses
      resources :requests
      resources :tickets do
        post 'responses', to: 'tickets#respond'
      end
      resources :agents
      resources :customers
    end
  end
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  mount ActionMailbox::Engine => '/rails/action_mailbox'
  # Defines the root path route ("/")
  # root "posts#index"
end
