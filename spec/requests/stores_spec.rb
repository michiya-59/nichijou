# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Stores", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/stores/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/stores/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/stores/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/stores/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
