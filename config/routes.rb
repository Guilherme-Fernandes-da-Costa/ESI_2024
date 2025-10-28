Rails.application.routes.draw do
    resources :lists do
    post 'reset', on: :member
    end
end