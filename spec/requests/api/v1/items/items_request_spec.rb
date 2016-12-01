require 'rails_helper'

describe "Items endpoint" do
  context "GET /api/v1/items" do
    it "returns a list of all items" do

      create_list(:item, 2)

      get '/api/v1/items'

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(2)
    end

    it "returns the show page for one item" do

      item1 = create(:item)
      item2 = create(:item)

      get "/api/v1/items/#{item1.id}"
      item_show = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_show["name"]).to eq(item1.name)
    end
  end

  context "GET /items/find" do
    let (:items) { create(:item) }

    it "finds a item by id" do
      get "/api/v1/items/find?id=#{items.id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["id"]).to eq(("#{items.id}").to_i)
    end
    it "finds a item by name" do
      get "/api/v1/items/find?name=#{items.name}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["name"]).to eq("#{items.name}")
    end
    it "finds a item by description" do
      get "/api/v1/items/find?description=#{items.description}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["description"]).to eq("#{items.description}")
    end
    it "finds a item by merchant_id" do
      get "/api/v1/items/find?merchant_id=#{items.merchant_id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["merchant_id"]).to eq(("#{items.merchant_id}").to_i)
    end
    it "finds a item by " do
      get "/api/v1/items/find?unit_price=#{items.unit_price}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["unit_price"]).to eq((("#{items.unit_price}").to_f/100).to_s)
    end
  end

  context "GET /items/:id/best_day" do
    it "returns the date with the most sales" do
      invoice = create(:invoice)
      invoice2 = create(:invoice, created_at: "2012-03-20T23:57:05.000Z".to_datetime)

      create(:transaction, invoice: invoice)

      item = create(:item)

      create_list(:invoice_item, 3, invoice: invoice, quantity: 1, item: item)
      create_list(:invoice_item, 4, invoice: invoice2, quantity: 1, item: item)

      get "/api/v1/items/#{item.id}/best_day"

      date = JSON.parse(response.body)

      expect(response).to be_success
      expect(date).to eq(JSON.parse(invoice2.created_at.to_json))
    end
  end

end
