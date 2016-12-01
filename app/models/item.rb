class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices,
    through: :invoice_items

    default_scope { order(:id) }

    def best_day
      invoice_items
      .joins(invoice: :transactions)
      .merge(Transaction.successful)
      .select("invoices.*, SUM(invoice_items.quantity) AS invoice_count")
      .group("invoices.id, invoices.created_at")
      .order("invoice_count DESC")
      .limit(1).first["created_at"]
    end

    def self.most_items(quantity)
      Item.unscoped.joins(:invoice_items, invoices: :transactions)
      .merge(Transaction.successful)
      .select("items.*, COUNT(invoice_items.id) AS appearance")
      .group("items.id")
      .order("appearance DESC")
      .limit(quantity)
    end

    def self.most_revenue(limit)
      Item.unscoped.joins(:invoice_items)
      .group(:id)
      .order('sum(invoice_items.quantity * invoice_items.unit_price)DESC')
      .limit(limit)
    end

end
