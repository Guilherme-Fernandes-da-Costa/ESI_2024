require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  describe "GET /create" do
    it "returns http success" do
      # These are protected endpoints that require authentication
      get "/friendships/create"
      # Without authentication, should redirect to login
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      # These are protected endpoints that require authentication
      get "/friendships/destroy"
      # Without authentication, should redirect to login
      expect(response).to have_http_status(:found)
    end
  end
end
