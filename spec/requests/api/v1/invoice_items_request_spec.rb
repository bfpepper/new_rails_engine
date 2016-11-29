require "rails_helper"

describe "Invoice Items endpoint" do
  context "GET /api/v1/invoice_items" do
    it "returns all invoice items" do

      create_list(:invoice_item, 2)

      get '/api/v1/invoice_items'

      total_invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(total_invoices.count).to eq(2)
    end

    it "returns an invoice given an ID" do

      invoice_items = create(:invoice_item)

      get "/api/v1/invoice_items/#{invoice_items.id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items["unit_price"]).to eq(invoice_items.unit_price)
    end
  end
end
