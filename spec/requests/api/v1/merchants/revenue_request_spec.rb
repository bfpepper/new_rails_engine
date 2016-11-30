require 'rails_helper'

describe "Merchant Revenue" do
  before(:each) do
    @merchant = create(:merchant, name: "Merchy Merch")
    @invoice1 = create(:invoice, merchant: @merchant)
    @transaction1 = create(:transaction, invoice: @invoice1)
    @invoice2 = create(:invoice, merchant: @merchant)
    @transaction2 = create(:transaction, result: "failed", invoice: @invoice2)
    @invoice_item1 = create(:invoice_item, invoice: @invoice1, quantity: 2, unit_price: 2)
    @invoice_item2 = create(:invoice_item, invoice: @invoice1, quantity: 2, unit_price: 2)
    @invoice_item3 = create(:invoice_item, invoice: @invoice2, quantity: 2, unit_price: 2)
  end

  context "GET /merchant/:id/revenue" do
    it "can get the revenue for a merchant" do
      get "/api/v1/merchants/#{@merchant.id}/revenue"

      revenue = JSON.parse(response.body)

      expect(response).to be_success
      expect(revenue).to eq(8)
    end
    it "can get a merchant's revenue for a date" do
      get "/api/v1/merchants/#{@merchant.id}/revenue?date=#{@invoice1.created_at}"
      revenue = JSON.parse(response.body)

      expect(response).to be_success
      expect(revenue).to eq(0)
    end
  end
end
