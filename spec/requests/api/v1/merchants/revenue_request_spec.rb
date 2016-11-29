require 'rails_helper'

describe "Merchant Revenue" do
  context "GET /merchant/:id/revenue" do
    it "can get the revenue for a merchant" do
      merchant = create(:merchant, name: "Merchy Merch")
      invoice = create(:invoice, merchant: merchant)
      create_list(:invoice_item, 2, invoice: invoice, quantity: 2, unit_price: 2)

      get "/api/v1/merchants/#{merchant.id}/revenue"

      revenue = JSON.parse(response.body)

      expect(response).to be_success
      expect(revenue).to eq(8)
    end
  end
end
