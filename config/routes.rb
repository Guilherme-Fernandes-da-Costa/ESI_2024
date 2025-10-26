Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

   # 1. Rota para o recurso 'Item'
  resources :items, path: 'lista' do
    # Rota para a ação de ordenação/filtragem
    collection do
      get 'sort'
    end
  end

  # Defines the root path route ("/")
  root "home#index" # <-- ESSA É A ÚNICA LINHA QUE VOCÊ PRECISA PARA A PÁGINA INICIAL
end
