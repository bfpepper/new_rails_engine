require 'rails_helper'

describe "Random Invoice" do
  context "GET /invoices/random" do
    it "finds a random invoice" do
      create_list(:invoice, 3)

      invoice_ids = Invoice.pluck(:id)

      get '/api/v1/invoices/random'

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_ids).to include(invoice["id"])
    end
  end
end
