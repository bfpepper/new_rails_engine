require 'rails_helper'

describe "Random Transactions" do
  context "GET /transactions/random" do
    it "finds a random transaction record" do
      transaction1 = create(:transaction)
      transaction2 = create(:transaction)

      transactions_id = Transaction.pluck(:id)

      get '/api/v1/transactions/random'

      transaction_found = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions_id).to include(transaction_found["id"])
    end
  end
end
