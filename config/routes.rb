# config/routes.rb
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index" # <-- ESSA É A ÚNICA LINHA QUE VOCÊ PRECISA PARA A PÁGINA INICIAL

  resources :lists do
    resources :items, only: [:new, :create, :index] do
      # Adiciona uma rota PATCH para uma action chamada 'toggle_comprado'
      # para um item específico (member)
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
