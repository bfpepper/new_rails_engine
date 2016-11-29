require "rails_helper"

describe "Invoice endpoint" do
  context "GET /api/v1/invoices" do
    it "returns all invoice" do

      customer = Customer.create(first_name: "Bill", last_name: "Joe")
      merchant = Merchant.create(name: "That")
      invoice1 = Invoice.create(merchant_id: "#{merchant.id}", customer_id: "#{customer.id}", status: "complete")
      invoice2 = Invoice.create(merchant_id: "#{merchant.id}", customer_id: "#{customer.id}", status: "shipped")

      get '/api/v1/invoices'

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(2)
    end

    it "returns a specific invoice" do
      customer = Customer.create(first_name: "Bill", last_name: "Joe")
      merchant = Merchant.create(name: "That")
      invoice1 = Invoice.create(merchant_id: "#{merchant.id}", customer_id: "#{customer.id}", status: "complete")
      invoice2 = Invoice.create(merchant_id: "#{merchant.id}", customer_id: "#{customer.id}", status: "shipped")

      get "/api/v1/invoices/#{invoice1.id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["status"]).to eq("#{invoice1.status}")
    end
  end
end
