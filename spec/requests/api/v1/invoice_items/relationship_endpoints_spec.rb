require "rails_helper"

context "GET /api/v1/invoice_items/:id/Params" do
  it "finds all invocies for a given invoice_item" do

    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice_id: invoice.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    returned_invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_invoice_items['id']).to eq(invoice.id)
  end

  it "finds all items for a given invoice_item" do

    item = create(:item)
    invoice_item = create(:invoice_item, item_id: item.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    returned_invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_invoice_items['name']).to eq(item.name)
  end
end
