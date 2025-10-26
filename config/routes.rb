# config/routes.rb
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index" # <-- ESSA É A ÚNICA LINHA QUE VOCÊ PRECISA PARA A PÁGINA INICIAL

  # Lista de itens
  resources :listas, controller: "lista", only: [:index, :show] do
    resources :items do
      collection do
        get :filter    # /listas/:lista_id/items/filter
        get :group     # /listas/:lista_id/items/group
      end
    end
  end

  get '/lista', to: 'lista#index'
  post '/lista', to: 'lista#create'
end
