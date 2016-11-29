require 'rails_helper'

describe "Items endpoint" do
  context "GET /api/v1/items" do
    it "returns a list of all items" do

      merchant = Merchant.create(name: "Bill")
      item1  = Item.create(name: "this", description: "that", unit_price: 12.45, merchant_id: "#{merchant.id}")
      item2  = Item.create(name: "You", description: "that", unit_price: 12.45, merchant_id: "#{merchant.id}")

      get '/api/v1/items'

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(2)
    end

    it "returns the show page for one item" do

      merchant = Merchant.create(name: "Bill")
      item1  = Item.create(name: "this", description: "that", unit_price: 12.45, merchant_id: "#{merchant.id}")
      item2  = Item.create(name: "You", description: "that", unit_price: 12.45, merchant_id: "#{merchant.id}")

      get "/api/v1/items/#{item1.id}"
      item_show = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_show["name"]).to eq(item1.name)
    end
  end
end
