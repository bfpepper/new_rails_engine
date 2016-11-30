require "rails_helper"

context "it can find a rendom record" do
  it "find a random merchant record" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    get "/api/v1/merchants/random"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(merchant1.id || merchant2.id)
  end
end
