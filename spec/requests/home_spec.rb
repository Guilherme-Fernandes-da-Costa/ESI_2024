# spec/requests/home_spec.rb (CORRIGIDO)

require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /" do # Você pode opcionalmente mudar a descrição aqui também
    it "returns http success" do
      get "/"  # <-- CORREÇÃO
      # Home page requires authentication, so redirects to login
      expect(response).to have_http_status(:found)
    end
  end
end
