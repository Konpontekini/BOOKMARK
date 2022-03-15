Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :items do
    member do
      patch :purchased
    end
    member do
      patch :unpurchased
    end
  end
  resources :categories
end
