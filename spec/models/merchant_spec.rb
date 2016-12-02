require 'rails_helper'

RSpec.describe Merchant, type: :model do

  context "Relationships" do
    it { should have_many(:invoices) }
    it { should have_many(:items) }
    it { should have_many(:customers) }
    it { should have_many(:invoice_items) }
  end

  context "Business Logic" do
    before(:each) do
      @merchant = create(:merchant, name: "Merchy Merch")
      @customer = create(:customer, first_name: "Custy", last_name: "Cust")
      @invoice1 = create(:invoice, merchant: @merchant, customer: @customer)
      @transaction1 = create(:transaction, invoice: @invoice1)
      @invoice2 = create(:invoice, merchant: @merchant)
      @transaction2 = create(:transaction, result: "failed", invoice: @invoice2)
      @invoice_item1 = create(:invoice_item, invoice: @invoice1, quantity: 2, unit_price: 2)
      @invoice_item2 = create(:invoice_item, invoice: @invoice1, quantity: 2, unit_price: 2)
      @invoice_item3 = create(:invoice_item, invoice: @invoice2, quantity: 2, unit_price: 2)
    end
    it "can get the revenue for a merchant" do
      expect(@merchant.total_revenue).to eq(8.0)
    end
    it "can get a merchant's revenue for a date" do
      expect(@merchant.total_revenue(@invoice1.created_at)).to eq(8.0)
    end
    it "can get the most revenue" do
      expect(Merchant.most_revenue(2).first).to eq(@merchant)
    end
    it "can find the favorite customer" do
      expect(@merchant.favorite_customer).to eq(@customer)
    end
    it "can find all revenue" do
      expect(Merchant.all_revenue(@invoice1.created_at)).to eq(8.0)
    end
  end
end
