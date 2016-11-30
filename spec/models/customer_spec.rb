require 'rails_helper'

RSpec.describe Customer, type: :model do
  context "Relationships" do
    it { should have_many(:invoices) }
    it "responds to assoc" do
      customer = create(:customer)
      expect(customer).to respond_to(:transactions)
    end
  end
end
