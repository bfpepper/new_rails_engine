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

  context "GET /merchants/find" do
    let (:merchant) { create(:merchant, name: "Find me") }

    it "finds a merchant based on name" do
      skip
      get "/api/v1/merchants/find?name=#{merchant.name}"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants["name"]).to eq("Find me")
    end
    it "finds a merchant based on id" do
      get "/api/v1/merchants/find?id=#{merchant.id}"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants["name"]).to eq("Find me")
    end
    it "finds a merchant based on created_at" do
      skip
      get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants["name"]).to eq("Find me")
    end

  end

  context "GET /merchants/:id/items" do
    it "returns all the items offered by a merchant" do

      merchant = create(:merchant)
      items = create_list(:item, 2, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/items"

      all_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(all_items.count).to eq(2)
    end
  end

  context "GET /merchants/:id/invoices" do
    it "returns all invoices for a given merchant" do
      merchant = create(:merchant)
      invoices = create_list(:invoice, 2, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/invoices"

      all_invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(all_invoices.count).to eq(2)
    end
  end
end
