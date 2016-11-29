require "rails_helper"

describe "Invoice endpoint" do
  context "GET /api/v1/invoices" do
    it "returns all invoice" do

      create_list(:invoice, 2)

      get '/api/v1/invoices'

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(2)
    end

    it "returns a specific invoice" do

      invoice1 = create(:invoice)
      invoice2 = create(:invoice)

      get "/api/v1/invoices/#{invoice1.id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["status"]).to eq("#{invoice1.status}")
    end
  end
end
