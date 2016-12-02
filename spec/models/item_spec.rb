require 'rails_helper'

RSpec.describe Item, type: :model do
  context "Relationships" do
    it { should belong_to(:merchant) }
  end

  context "Business Logic" do
    it "returns the best day" do
      invoice = create(:invoice)
      invoice2 = create(:invoice, created_at: "2012-03-20T23:57:05.000Z".to_datetime)

      create(:transaction, invoice: invoice)
      create(:transaction, invoice: invoice2)

      item = create(:item)

      create_list(:invoice_item, 3, invoice: invoice, quantity: 1, item: item)
      create_list(:invoice_item, 4, invoice: invoice2, quantity: 1, item: item)

      expect(item.best_day).to eq(invoice2.created_at)
    end
    it "finds most items" do
        item1 = create(:item, name: "Bread")
        item2 = create(:item, name: "Meat")
        item3 = create(:item, name: "Cheese")

        invoice = create(:invoice)

        create(:transaction, invoice: invoice)

        create_list(:invoice_item, 1, invoice: invoice, quantity: 1, item: item1)
        create_list(:invoice_item, 2, invoice: invoice, quantity: 1, item: item2)
        create_list(:invoice_item, 3, invoice: invoice, quantity: 1, item: item3)

        quantity = 2

        expect(Item.most_items(quantity)).to eq([item3, item2])
    end
    it "finds most revenue" do
      item1 = create(:item, name: "Bread")
      item2 = create(:item, name: "Meat")
      item3 = create(:item, name: "Cheese")

      invoice = create(:invoice)

      create(:transaction, invoice: invoice)

      create_list(:invoice_item, 1, invoice: invoice, quantity: 1, item: item1)
      create_list(:invoice_item, 2, invoice: invoice, quantity: 1, item: item2)
      create_list(:invoice_item, 3, invoice: invoice, quantity: 1, item: item3)

      quantity = 2

      expect(Item.most_items(quantity)).to eq([item3, item2])
    end
  end
end
