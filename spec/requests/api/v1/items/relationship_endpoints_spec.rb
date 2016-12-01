require "rails_helper"

context "GET /api/v1/items/:id/Params" do
  it "finds all invoice_items for a given item" do

    item = create(:item)
    create_list(:invoice_item, 2, item_id: item.id)

    get "/api/v1/items/#{item.id}/invoice_item"

    returned_list = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_list.count).to eq(2)
  end

  it "finds all merchants for a given item" do

    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    returned_list = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_list.count).to eq(1)
  end
end
