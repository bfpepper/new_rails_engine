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

  context "GET /invoices/find" do
    let (:invoices) { create(:invoice) }

    it "finds an invoice by id" do
      get "/api/v1/invoices/find?id=#{invoices.id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["id"]).to eq(("#{invoices.id}").to_i)
    end
    it "finds an invoice by status" do
      get "/api/v1/invoices/find?status=#{invoices.status}"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["status"]).to eq("#{invoices.status}")
    end
    it "finds an invoice by customer_id" do
      get "/api/v1/invoices/find?customer_id=#{invoices.customer_id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["customer_id"]).to eq(("#{invoices.customer_id}").to_i)
    end
    it "finds an invoice by merchant_id" do
      get "/api/v1/invoices/find?merchant_id=#{invoices.merchant_id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["merchant_id"]).to eq(("#{invoices.merchant_id}").to_i)
    end
  end

  context "GET /invoices/:id/transactions" do
    it "returns a collection of transactions" do
      invoice = create(:invoice)
      transaction = create_list(:transaction, 2, invoice: invoice)

      get "/api/v1/invoices/#{invoice.id}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)
    end
  end
  context "GET /invoices/:id/invoice_items" do
    it "returns a collection of invoice items" do
      invoice = create(:invoice)
      transaction = create_list(:invoice_item, 2, invoice: invoice)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)
    end
  end
  context "GET /invoices/:id/items" do
    it "returns a collection of items" do
      invoice = create(:invoice)
      item = create(:item)
      transaction = create_list(:invoice_item, 2, invoice: invoice, item: item)

      get "/api/v1/invoices/#{invoice.id}/items"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)
    end
  end
  context "GET /invoices/:id/customer" do
    it "returns a single customer" do
      customer = create(:customer, first_name: "Todd")
      invoice = create(:invoice, customer: customer)

      get "/api/v1/invoices/#{invoice.id}/customer"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers["first_name"]).to eq("Todd")
    end
  end
  context "GET /invoices/:id/merchant" do
    it "returns a single merchant" do
      merchant = create(:merchant, name: "Merchy Merch")
      invoice = create(:invoice, merchant: merchant)

      get "/api/v1/invoices/#{invoice.id}/merchant"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["name"]).to eq("Merchy Merch")
    end
  end
  context "GET /invoices/find_all?given_parameter=search_param" do
    it "finds all invoices for a given customer_id" do
      customer = create(:customer)
      invoice = create_list(:invoice, 3, customer: customer)

      get "/api/v1/invoices/find_all?customer_id=#{customer.id}"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end

    it "finds all invoices by a given merchant id" do
      merchant = create(:merchant)
      invoice = create_list(:invoice, 3, merchant: merchant)

      get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end

    it "finds all invoices by a given status" do
      invoices = create_list(:invoice, 2, status: "success")
      invoice = create(:invoice, status: "fail")

      get "/api/v1/invoices/find_all?status=success"

      correct_invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(correct_invoices.count).to eq(2)
    end
  end

  context "GET /invoices/random" do
    it "returns a random invoice" do
      invoice1 = create(:invoice)
      invoice2 = create(:invoice)

      invoice_ids = Invoice.all.pluck(:id)

      get "/api/v1/invoices/random"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_ids).to include(invoice["id"])
    end
  end
end
