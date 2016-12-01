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

  context "GET /invoice_items/find" do
    let (:invoice_items) { create(:invoice_item) }

    it "finds a invoice item by id" do
      get "/api/v1/invoice_items/find?id=#{invoice_items.id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item["id"]).to eq(("#{invoice_items.id}").to_i)
    end
    it "finds a invoice item by unit_price" do
      get "/api/v1/invoice_items/find?unit_price=#{invoice_items.unit_price}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items["unit_price"]).to eq(("#{invoice_items.unit_price}").to_f)
    end
    it "finds a invoice item by item_id" do
      get "/api/v1/invoice_items/find?item_id=#{invoice_items.item_id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item["item_id"]).to eq(("#{invoice_items.item_id}").to_i)
    end
    it "finds a invoice item by invoice_id" do
      get "/api/v1/invoice_items/find?invoice_id=#{invoice_items.invoice_id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item["invoice_id"]).to eq(("#{invoice_items.invoice_id}").to_i)
    end
    it "finds a invoice item by quantity" do
      get "/api/v1/invoice_items/find?quantity=#{invoice_items.quantity}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item["quantity"]).to eq(("#{invoice_items.quantity}").to_i)
    end
  end
end
