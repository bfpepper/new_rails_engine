require 'rails_helper'

describe "customers endpoints" do
  context "GET /customers" do
    it "returns a list of all customers" do
      create_list(:customer, 2)

      get "/api/v1/customers.json"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(2)
    end
  end
  context "GET /customer" do
    it "returns one customer" do
      customer = create(:customer, first_name: "Danny", last_name: "Tanner")

      get "/api/v1/customers/#{customer.id}.json"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers["first_name"]).to eq("Danny")
    end
  end
end
