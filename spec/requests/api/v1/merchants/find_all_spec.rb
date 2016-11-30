require "rails_helper"

context "Can find all records for a given parameter" do
  it "finds all records for a given name" do
    merchants = create_list(:merchant, 2, name: "Bill")

    get "/api/v1/merchants/find_all?name=Bill"

    merchants_list = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants_list.count).to eq(2)
  end
end
