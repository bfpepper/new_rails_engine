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
end
