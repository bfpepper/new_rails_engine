require "rails_helper"

context "GET /invoice_items/random" do
  it "finds a random record" do
    invoice_item1 = create(:invoice_item)
    invoice_item2 = create(:invoice_item)

    get '/api/v1/invoice_items/random'

    returned_invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_invoice_item["id"]).to eq(invoice_item1.id || invoice_item2.id)
  end
end
