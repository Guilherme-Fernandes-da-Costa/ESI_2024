# config/routes.rb
Rails.application.routes.draw do
<<<<<<< HEAD
  get "friendships/create"
  get "friendships/destroy"
  root "home#index"

  # Rotas de autenticação
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"
  post "signup", to: "users#create"
=======
  root "home#index"

  # Rotas de autenticação
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
>>>>>>> 0d98f6d (Implementa sistema de autenticação)

  resources :lists do
    post "reset", on: :member
    post "share", on: :member      # Nova rota para compartilhar
    delete "unshare", on: :member  # Nova rota para remover compartilhamento

    resources :items, only: [ :new, :create, :index, :update ] do
      member do
        patch :toggle_comprado
      end
    end
  end

  # Rota para o BDD
<<<<<<< HEAD
  get "lista", to: "lists#index"

  resources :friendships, only: [ :create, :destroy ]

  get "/friends", to: "friendships#index", as: "friends"
end
=======
  get 'lista', to: 'lists#index'
end
>>>>>>> 0d98f6d (Implementa sistema de autenticação)
