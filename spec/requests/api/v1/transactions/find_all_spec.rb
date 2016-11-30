require "rails_helper"

context "Finds all records by a given parameter" do
  it "finds all records give a invoice_id" do
    invoice = create(:invoice)
    create_list(:transaction, 3, invoice_id: "#{invoice.id}")

    get "/api/v1/transactions/find_all?invoice_id=#{invoice.id}"

    trans_list = JSON.parse(response.body)

    expect(response).to be_success
    expect(trans_list.count).to eq(3)
  end

  it "finds all records for a given CC number" do
    create_list(:transaction, 3, credit_card_number: 456)

    get "/api/v1/transactions/find_all?credit_card_number=456"

    trans_list = JSON.parse(response.body)

    expect(response).to be_success
    expect(trans_list.count).to eq(3)
  end

  it "finds all records for a given cc exp date" do
    create_list(:transaction, 3, credit_card_expiration_date: "11/7")

    get "/api/v1/transactions/find_all?credit_card_expiration_date=11/7"

    trans_list = JSON.parse(response.body)

    expect(response).to be_success
    expect(trans_list.count).to eq(3)
  end

  it "finds all records for a given result" do
    create_list(:transaction, 3, result: "success")

    get "/api/v1/transactions/find_all?status=success"

    trans_list = JSON.parse(response.body)

    expect(response).to be_success
    expect(trans_list.count).to eq(3)
  end
end

# "invoice_id"
# "credit_card_number"
# "credit_card_expiration_date"
# "result"
