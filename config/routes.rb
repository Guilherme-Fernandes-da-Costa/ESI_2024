# config/routes.rb
Rails.application.routes.draw do
  root "home#index"

  # Rotas de autenticação
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  resources :lists do
    post 'reset', on: :member
    resources :items, only: [:new, :create, :index, :update] do
      member do
        patch :toggle_comprado
      end
    end
  end

  # Rota para o BDD
  get 'lista', to: 'lists#index'
end