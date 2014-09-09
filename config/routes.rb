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

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
