require "rails_helper"

context "GET /invoice_items/random" do
  it "finds a random record" do
    invoice_item1 = create(:invoice_item)
    invoice_item2 = create(:invoice_item)

    invoice_item_ids = InvoiceItem.all.pluck(:id)

    get '/api/v1/invoice_items/random'

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item_ids).to include(invoice_item["id"])
  end
end
