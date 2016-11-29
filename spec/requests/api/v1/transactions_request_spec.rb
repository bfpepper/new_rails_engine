require 'rails_helper'

describe "merchants endpoints" do
  context "GET /transactions" do
    it "returns a list of all transactions" do
      create_list(:transaction, 2)

      get "/api/v1/transactions.json"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)
    end
  end
  context "GET /transaction" do
    it "returns one transaction" do
      transaction = create(
                          :transaction,
                          invoice: Invoice.create(status:"failed", merchant_id: 1, customer_id: 1),
                          credit_card_number: "1234",
                          credit_card_expiration_date: "123",
                          result: "passed"
                          )

      get "/api/v1/transactions/#{transaction.id}.json"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions["credit_card_number"]).to eq("1234")
    end
  end
  context "GET /transactions/find" do
    it "can find a transaction" do

    end
  end
end
