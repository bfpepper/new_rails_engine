require 'rails_helper'

describe "Find all Customers" do
  context "GET /customers/find_all?first_name=x" do
    it "finds all customers" do
      name = "Bob"
      create_list(:customer, 2, first_name: name)
      create(:customer)

      get "/api/v1/customers/find_all?first_name=#{name}"

      trans_list = JSON.parse(response.body)

      expect(response).to be_success
      expect(trans_list.count).to eq(2)
      expect(trans_list.first["first_name"]).to eq(name)
    end
  end
end
