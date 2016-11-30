require "rails_helper"

context "GET /api/v1/merchats/:id/favorite_customer" do
  it "can find the customer who has dont the most business for a given merchant" do
    customer1 = create(:customer)
    customer2 = create(:customer)
    merchant = create(:merchant)
    invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
    invoice2 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
    invoice3 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
    create(:transaction, invoice_id: invoice1.id)
    create(:transaction, invoice_id: invoice2.id)
    create(:transaction, invoice_id: invoice3.id)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    favorite_customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(favorite_customer["id"]).to eq(customer1.id)
  end
end
