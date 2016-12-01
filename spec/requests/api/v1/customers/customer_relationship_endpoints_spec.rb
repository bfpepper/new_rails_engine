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
end
