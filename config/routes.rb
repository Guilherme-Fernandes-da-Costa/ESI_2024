Rails.application.routes.draw do
  root to: 'home#index' if defined?(HomeController)

  resources :lists do
    post 'reset', on: :member
  end

  # outras rotas...
end
