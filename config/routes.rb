Rails.application.routes.draw do
  get 'dogs/show'
  get 'dogs/index'
  devise_for :users
  root to: 'pages#home'
  # a guest can create a user, a user can see his profile and edit his profile
  resources :users, only: [:show, :new, :create, :edit] do
    resources :dogs, only: [:new, :create]
  end
  # all 7 crud action can be done for dogs.
  resources :dogs, except: [:new, :create] do
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
