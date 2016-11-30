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
    it "finds a item by unit_price" do
      get "/api/v1/items/find?unit_price=#{items.unit_price}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["unit_price"]).to eq(("#{items.unit_price}").to_i)
    end
    # it "finds a item by created_at" do
    #   get "/api/v1/items/find?created_at=#{items.created_at}"
    #
    #   item = JSON.parse(response.body)
    #
    #   expect(response).to be_success
    #   expect(item["created_at"]).to eq(("#{items.created_at}").to_i)
    # end
    # it "finds a item by updated_at" do
    #   get "/api/v1/items/find?updated_at=#{items.updated_at}"
    #
    #   item = JSON.parse(response.body)
    #
    #   expect(response).to be_success
    #   expect(item["updated_at"]).to eq(("#{items.updated_at}").to_i)
    # end
  end
end
