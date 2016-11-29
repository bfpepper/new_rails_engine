require 'rails_helper'

describe "transaction endpoints" do
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
    let (:transactions) { create(:transaction) }

    it "finds a transaction by id" do
      get "/api/v1/transactions/find?id=#{transactions.id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["id"]).to eq(("#{transactions.id}").to_i)
    end
    it "finds a transaction by invoice_id" do
      get "/api/v1/transactions/find?invoice_id=#{transactions.invoice_id}"

      # byebug
      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["invoice_id"]).to eq(("#{transactions.invoice_id}").to_i)
    end
    it "finds a transaction by credit_card_number" do
      get "/api/v1/transactions/find?credit_card_number=#{transactions.credit_card_number}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["credit_card_number"]).to eq("#{transactions.credit_card_number}")
    end
    it "finds a transaction by credit_card_expiration_date" do
      get "/api/v1/transactions/find?credit_card_expiration_date=#{transactions.credit_card_expiration_date}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["credit_card_expiration_date"]).to eq("#{transactions.credit_card_expiration_date}")
    end
    it "finds a transaction by result" do
      get "/api/v1/transactions/find?result=#{transactions.result}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["result"]).to eq("#{transactions.result}")
    end
    # it "finds a transaction by created_at" do
    #   get "/api/v1/transactions/find?created_at=#{transactions.created_at}"
    #
    #   transaction = JSON.parse(response.body)
    #
    #   expect(response).to be_success
    #   expect(transaction["created_at"]).to eq(("#{transactions.created_at}").to_i)
    # end
    # it "finds a transaction by updated_at" do
    #   get "/api/v1/transactions/find?updated_at=#{transactions.updated_at}"
    #
    #   transaction = JSON.parse(response.body)
    #
    #   expect(response).to be_success
    #   expect(transaction["updated_at"]).to eq(("#{transactions.updated_at}").to_i)
    # end
  end
end
