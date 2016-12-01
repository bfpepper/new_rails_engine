require "rails_helper"

context "GET /api/v1/items/most_revenue?quantity=x" do
  it "returns the top x items ranked by total revenue" do

    merchant = create(:merchant)
    invoice = create(:invoice)
    item1 = create(:item, name: "This")
    item2 = create(:item, name: "That")
    item3 = create(:item, name: "Other")
    invoice_item1 = create(:invoice_item, invoice_id: invoice.id, item: item1, quantity: 3)
    invoice_item2 = create(:invoice_item, invoice_id: invoice.id, item: item2, quantity: 2)
    invoice_item3 = create(:invoice_item, invoice_id: invoice.id, item: item3, quantity: 1)
    transaction = create(:transaction, invoice_id: invoice.id, result: "success")

    get '/api/v1/items/most_revenue?quantity=2'

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.first["name"]).to eq(item1.name)
  end
end
