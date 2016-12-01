require "rails_helper"

context "GET /api/v1/merchants/revenue?date=x" do
  it "returns all revenue for a given date for all merchants" do

    date = '2016-12-01 16:13:19'

    merch1, merch2 = create_list(:merchant, 2)
    invoice1 = create(:invoice, merchant: merch1, created_at: date.to_datetime)
    invoice2 = create(:invoice, merchant: merch2, created_at: "2012-03-20T23:57:05.000Z".to_datetime)
    create_list(:invoice_item, 2, invoice: invoice1, quantity: 1, unit_price: 2)
    create(:transaction, result: "success", invoice: invoice1)
    create(:transaction, result: "success", invoice: invoice2)
    create(:invoice_item, invoice: invoice2, quantity: 1, unit_price: 2)

    get "/api/v1/merchants/revenue?date=#{date}"

    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue["total_revenue"]).to eq('0.04')
  end
end
