Rails.application.routes.draw do
    root to: 'home#index'
    resources :lists do
        post 'reset', on: :member
    end
end