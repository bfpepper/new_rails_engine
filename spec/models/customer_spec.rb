require 'rails_helper'

RSpec.describe Customer, type: :model do
  context "Validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it "does not repeat first_name and last_name combo" do
      customer1 = Customer.create(first_name: "Danny", last_name:"Tanner")
      customer2 = Customer.new(first_name: "Danny", last_name:"Tanner")

      expect(customer2).to be_invalid
    end
  end

  context "Relationships" do
    it { should have_many(:invoices) }
    it "responds to assoc" do
      customer = create(:customer)
      expect(customer).to respond_to(:transactions)
    end
  end
end
