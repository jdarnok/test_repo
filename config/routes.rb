Rails.application.routes.draw do
    namespace :api, defaults: { format: 'json' } do
      scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
          resources :projects
        end
    end


  root to: 'visitors#index'
  devise_for :users
  resources :users do
    post 'generate_token', on: :member
  end
end
