Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'sign_in',
    sign_out: 'sign_out',
    password: 'password',
    confirmation: 'confirmation',
    unlock: 'unlock',
    registration: 'registration',
    sign_up: 'sign_up'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    # passwords: 'custom_passwords',
    confirmations: 'users/confirmations',
    # unlocks: 'custom_unlocks'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "albums#index_feed"
  get "feeds/photos", to: "photos#index_feed"
  get "pending", to: "pending_users#index"
  scope module: "admin" do
    get "authorizations", to: "authorizations#index"
    get "unauthorized", to: "unauthorizations#index"
  end
  # scope "guest" do
  #   get "authorizations", to: "authorizations#index", as: "guest_authorizations"
  #   get "unauthorized", to: "unauthorizations#index", as: "guest_unauthorizations"
  # end

  # namespace :guest do
  #   get "authorizations", to: "authorizations#index"
  #   get "unauthorized", to: "unauthorizations#index"
  # end
  scope "discovers" do
    get "/", to: "albums#index_discover", as: "discover"
    get "/photos", to: "photos#index_discover", as: "discover_photos"
    get "/photos/:id", to: "photos#discover_user_photos_index", as: "discover_photo"
    get "/albums/:id", to: "albums#discover_user_index", as: "discover_album"
    get "/followees/:id", to: "followees#discover_followee_index", as: "discover_followee"
    get "/followers/:id", to: "followers#discover_follower_index", as: "discover_follower"
  end
  resources :photos, :albums
  resources :followees, only: [:index, :create, :destroy]
  resources :followers, only: [:index, :create, :destroy]
  resources :profiles , only: [:edit, :update]
  resources :passwords , only: [:edit, :update]
  resources :likes, only: [:create, :destroy]
  get 'search', to: "search#index"

  namespace :admin do
    resources :photos, :albums, :users
  end
end
