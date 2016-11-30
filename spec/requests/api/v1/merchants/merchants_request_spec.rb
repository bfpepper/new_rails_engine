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
    it "finds a merchant based on updated_at" do
      skip
      get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants["name"]).to eq("Find me")
    end
  end

  context "GET /merchants/most_revenue?quantity=x" do
    it "ranks merchants by total revenue" do
      merchant1 = create(:merchant, name: "Show this")
      merchant2 = create(:merchant, name: "Show that")
      merchant3 = create(:merchant, name: "No")

      invoice1 = create(:invoice, merchant: merchant1)
      invoice2 = create(:invoice, merchant: merchant2)
      invoice3 = create(:invoice, merchant: merchant3)

      create(:transaction, result: "success", invoice:invoice1)
      create(:transaction, result: "success", invoice:invoice2)
      create(:transaction, result: "success", invoice:invoice3)

      create_list(:invoice_item, 2, invoice: invoice1, unit_price: 2)
      create_list(:invoice_item, 2, invoice: invoice2, unit_price: 1)
      create(:invoice_item, invoice: invoice3, unit_price: 1)

      get "/api/v1/merchants/most_revenue?quantity=2"

      all_invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(all_invoices.count).to eq(2)
      expect(all_invoices.first["name"]).to eq("Show this")
    end
  end

  context "GET /merchants/most_items?quantity=x" do
    it "ranks merchants by most items" do
      merchant1 = create(:merchant, name: "Show this")
      merchant2 = create(:merchant, name: "Show that")
      merchant3 = create(:merchant, name: "No")

      invoice1 = create(:invoice, merchant: merchant1)
      invoice2 = create(:invoice, merchant: merchant2)
      invoice3 = create(:invoice, merchant: merchant3)

      create(:transaction, result: "success", invoice:invoice1)
      create(:transaction, result: "success", invoice:invoice2)
      create(:transaction, result: "success", invoice:invoice3)

      create_list(:invoice_item, 2, invoice: invoice1, quantity: 2)
      create_list(:invoice_item, 2, invoice: invoice2, quantity: 1)
      create(:invoice_item, invoice: invoice3, quantity: 1)

      get "/api/v1/merchants/most_items?quantity=2"

      all_invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(all_invoices.count).to eq(2)
      expect(all_invoices.first["name"]).to eq("Show this")
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
