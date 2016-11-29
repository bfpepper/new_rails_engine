require "rails_helper"

describe "Invoice Items endpoint" do
  context "GET /api/v1/invoice_items" do
    it "returns all invoice items" do

      merchant = Merchant.create(name: "Bill")
      customer = Customer.create(first_name: "Bill", last_name: "Joe")
      invoice = Invoice.create(merchant_id: "#{merchant.id}", customer_id: "#{customer.id}", status: "complete")
      item  = Item.create(name: "this", description: "that", unit_price: 12.45, merchant_id: "#{merchant.id}")
      invoice_items1 = InvoiceItem.create(item_id: "#{item.id}", invoice_id: "#{invoice.id}", quantity: 2, unit_price: 54)
      invoice_items2 = InvoiceItem.create(item_id: "#{item.id}", invoice_id: "#{invoice.id}", quantity: 3, unit_price: 54)

      get '/api/v1/invoice_items'

      total_invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(total_invoices.count).to eq(2)
    end

    it "returns an invoice given an ID" do
      merchant = Merchant.create(name: "Bill")
      customer = Customer.create(first_name: "Bill", last_name: "Joe")
      invoice = Invoice.create(merchant_id: "#{merchant.id}", customer_id: "#{customer.id}", status: "complete")
      item  = Item.create(name: "this", description: "that", unit_price: 12.45, merchant_id: "#{merchant.id}")
      invoice_items = InvoiceItem.create(item_id: "#{item.id}", invoice_id: "#{invoice.id}", quantity: 2, unit_price: 54)


      get "/api/v1/invoice_items/#{invoice_items.id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items["unit_price"]).to eq(54.0)
    end
  end
end
