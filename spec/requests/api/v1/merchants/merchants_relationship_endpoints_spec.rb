require 'rails_helper'

describe "Merchants relationship endpoints" do
  context "GET /merchants/:id/items" do
    it "can return a merchant's items" do
      merchant = create(:merchant)
      item1, item2 = create_list(:item, 2, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(2)
      expect(items.first['name']).to eq(item1.name)
    end
  end
  context "GET /merchants/:id/invoices" do
    it "can return a merchant's invoices" do
      merchant = create(:merchant)
      invoice1, invoice2 = create_list(:invoice, 2, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(2)
      expect(invoices.first['id']).to eq(invoice1.id)
    end
  end
end
