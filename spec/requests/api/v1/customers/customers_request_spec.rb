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
  context "GET /customers/:id" do
    it "returns one customer" do
      customer = create(:customer, first_name: "Danny", last_name: "Tanner")

      get "/api/v1/customers/#{customer.id}.json"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers["first_name"]).to eq("Danny")
    end
  end

  context "GET /customers/find" do
    let (:customers) { create(:customer) }

    it "finds a customer by id" do
      get "/api/v1/customers/find?id=#{customers.id}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["id"]).to eq(("#{customers.id}").to_i)
    end
    it "finds a customer by first_name" do
      get "/api/v1/customers/find?first_name=#{customers.first_name}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["first_name"]).to eq("#{customers.first_name}")
    end
    it "finds a customer by last_name" do
      get "/api/v1/customers/find?last_name=#{customers.last_name}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["last_name"]).to eq("#{customers.last_name}")
    end
  end
end
