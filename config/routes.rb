Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # a guest can create a user, a user can see his profile and dashboard
  resources :users, only: [:show] do
    member do
      get 'dashboard'
    end
  end
  # all 7 crud action can be done for dogs.
  resources :dogs do
    # a guest can preview a specific dog page before login-in
    member do
      get 'preview'
    end
    # a user can create a new booking
    resources :bookings, only: [:new, :create]
  end
  # a user can see details of one booking and delete.
  resources :bookings, only: [:show, :destroy]
  # can create a review
  resources :reviews, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
