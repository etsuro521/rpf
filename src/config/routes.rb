Rails.application.routes.draw do
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/confirm', to:'static_pages#confirm'
  get '/goals', to:'static_pages#goals'
  resources :tasks do
    collection do
      get :change
    end
  end
  resources :groups do
    member do
      post :change, :add
    end
    get "search", on: :collection
  end
  resources :user_groups, only: [:edit,:update,:destroy]
  resources :teams do
    member do
      post :add
      get :search, :confirm
    end
    post "change", on: :collection
  end
  resources :user_teams, only: [:destroy]
  resources :monthly_goals do
    collection do
      post :change, :store
    end
  end
  resources :weekly_goals do
    collection do
      post :store, :week, :whose
    end
  end
  match "*path" => "application#error404", via: :all
end

