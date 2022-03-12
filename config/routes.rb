Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :items do
    collection do
      get :purchased
    end
  end
  resources :categories
end
