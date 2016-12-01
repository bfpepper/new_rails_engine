require 'rails_helper'

describe "Transaction Relationship Endpoints" do
  context "GET /transactions/:id/invoice" do
    it "can find the associated invoice" do

      invoice = create(:invoice)
      transaction = create(:transaction, invoice: invoice)

      get "/api/v1/transactions/#{transaction.id}/invoice"

      invoice_found = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_found['id']).to eq(invoice.id)
    end
  end
end
