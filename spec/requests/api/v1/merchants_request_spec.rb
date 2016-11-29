require 'rails_helper'

describe "merchants endpoints" do
  context "GET /merchants" do
    it "returns a list of all merchants" do
      create_list(:merchant, 2)

      get "/api/v1/merchants.json"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants.count).to eq(2)
    end
  end
  context "GET /merchant" do
    it "returns one merchant" do
      merchant = create(:merchant, name: "Merchy Merch")

      get "/api/v1/merchants/#{merchant.id}.json"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["name"]).to eq("Merchy Merch")
    end
  end
end
