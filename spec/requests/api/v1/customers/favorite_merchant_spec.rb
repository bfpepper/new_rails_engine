require "rails_helper"

context "GET /api/v1/customers/:id/favorite_merchant" do
  it "find the merchant a given customer does the most business with" do

      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      customer = create(:customer)
      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
      create(:transaction, invoice_id: invoice1.id)
      create(:transaction, invoice_id: invoice2.id)
      create(:transaction, invoice_id: invoice3.id)

      get "/api/v1/customers/#{customer.id}/favorite_merchant"

      favorite_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(favorite_merchant["id"]).to eq(merchant1.id)
  end
end
