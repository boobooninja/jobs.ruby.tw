Rails.application.routes.draw do
  resources :jobs do
    member do
      put :open
      put :close
    end
    collection do
      post :preview
      put :preview
    end
  end

  root to: 'jobs#index'

  get 'about', to: 'visitors#about'

  devise_for :users
  resources :users
end
