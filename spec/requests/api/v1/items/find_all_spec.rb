require "rails_helper"

context "It finds all records by a given param" do
  it "finds all items given name" do

    create_list(:item, 3, name: "thing")

    get "/api/v1/items/find_all?name=thing"

    items_list = JSON.parse(response.body)

    expect(response).to be_success
    expect(items_list.count).to eq(3)
  end

  it "finds all records by a given description" do

    create_list(:item, 3, description: "this")

    get "/api/v1/items/find_all?description=this"

    items_list = JSON.parse(response.body)

    expect(response).to be_success
    expect(items_list.count).to eq(3)
  end

  it "finds all records given a merchant_id" do

    merch = create(:merchant)
    create_list(:item, 3, merchant_id: "#{merch.id}")

    get "/api/v1/items/find_all?mercahnt_id=#{merch.id}"

    items_list = JSON.parse(response.body)

    expect(response).to be_success
    expect(items_list.count).to eq(3)
  end
end
