require 'rails_helper'

describe "Random Customer" do
  context "GET /customers/random" do
    it "finds a random customer" do
      create_list(:customer, 3)

      customer_ids = Customer.pluck(:id)

      get '/api/v1/customers/random'

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer_ids).to include(customer["id"])
    end
  end
end
