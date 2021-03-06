Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "user_requests#index"

  resources :user_requests

  resources :attachments, only: :destroy

  namespace 'admin' do
    get '/' => 'user_requests#index'

    resources :user_requests
    resources :users
  end
end
