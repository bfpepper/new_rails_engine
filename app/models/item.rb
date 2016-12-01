class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices,
    through: :invoice_items

    def best_day
      invoice_items.joins(invoice: :transactions)
      .merge(Transaction.successful)
      .select("COUNT(invoice_items.id) AS invoice_count, invoices.id, invoices.created_at")
      .group("invoices.id, invoices.created_at")
      .order("invoice_count DESC")
      .limit(1).first["created_at"]
    end

    def self.most_items(quantity)
      joins(:invoice_items, invoices: :transactions)
      .merge(Transaction.successful)
      .select("items.*, COUNT(invoice_items.id) AS appearance")
      .group("items.id")
      .order("appearance DESC")
      .limit(quantity)
    end

end
