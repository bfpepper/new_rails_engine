require 'rails_helper'

describe "Customer Relationship Endpoints" do
  context "GET /customers/:id/invoices" do
    it "can find customer invoices" do
      customer = create(:customer)

      create_list(:invoice, 2, customer: customer)

      get "/api/v1/customers/#{customer.id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(2)
    end
  end

  context "GET /customers/:id/transactions" do
    it "can find customer transactions" do
      customer = create(:customer)
      invoice = create(:invoice, customer: customer)

      create_list(:transaction, 2, invoice: invoice)

      get "/api/v1/customers/#{customer.id}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)
    end
  end
end
