Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # a guest can create a user, a user can see his profile and edit his profile
  resources :users, only: [:show]
  # all 7 crud action can be done for dogs.
  resources :dogs do
    # a guest can preview a specific dog page before login-in
    member do
      get 'preview'
    end
  end
  # can see details of one booking, create and delete.
  resources :bookings, only: [:show, :new, :create, :delete]
  # can create a review
  resources :reviews, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
