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
  
  # Rota para o cenário "Dado que exista um item 'Leite' na minha lista"
  # Se sua lista principal for /lists/1/items (o index), esta rota não é estritamente necessária,
  # mas a mantenha se o seu BDD usa o path literal "/lista".
  # Se precisar dela, desaninha e aponte para o index:
  # get 'lista', to: 'lists#index' 
  
end
