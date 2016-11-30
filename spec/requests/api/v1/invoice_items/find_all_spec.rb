# find_all for Item_id, Invoice_id, quantity,
              #unit_price
require "rails_helper"

context "It can find all the records for a given search parameter" do
  it "finds all records for a given item_id" do
    item = create(:item)
    invoice_items = create_list(:invoice_item, 3, item_id: item.id)

    get "/api/v1/invoice_items?find_all?item_id=#{item.id}"

    all_invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_invoice_items.count).to eq(3) 
  end
end
