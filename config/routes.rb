Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :sessions, only: [ :create, :destroy ]
      resources :users, only: [:create] do
        collection do
          get 'me'
        end
      end

      resources :authorize, only: [] do
        collection do
          [:fitbit, :healthvault, :jawbone, :runkeeper, :withings, :fatsecret].each do |tracker|
            get tracker
            get "#{tracker}/callback", to: "authorize#tracker_callback"
          end
        end
      end

      resources :trackers, only: [:index, :destroy]

      resources :dashboard, only: [] do
        collection do
          get 'metrics'
        end
      end

      resources :scores, only: [:show]
    end
  end
end
