Rails.application.routes.draw do


  use_doorkeeper
  namespace :api, defaults: { format: 'json' } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      resources :projects
      resources :commits
      resources :branches
    end
     scope module: :v2, constraints: ApiConstraints.new(version: 2, default: :true) do
    #   resources :projects
       resources :commits
       resources :branches
     end
  end


  root to: 'visitors#index'
  devise_for :users
  resources :users do
    post 'generate_token', on: :member

  end

end
