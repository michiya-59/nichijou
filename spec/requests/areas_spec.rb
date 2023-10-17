require 'rails_helper'

RSpec.describe "Areas", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/areas/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/areas/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/areas/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/areas/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/areas/index"
      expect(response).to have_http_status(:success)
    end
  end

end
