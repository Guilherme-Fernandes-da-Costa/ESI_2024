Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#index"

  resources :lists do
    post 'reset', on: :member
    resources :items, only: [:new, :create, :index] do
      member do
        patch :toggle_comprado
      end
    end
  end

  # Rota para o formulário de cadastro (ou tela de edição)
  get 'cadastro', to: 'itens#new', as: :cadastro
  
  # Adicione esta linha para o BDD
  # Mapeia /lista para a action index do ListsController
  get 'lista', to: 'lists#index' 
end