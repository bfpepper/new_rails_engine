class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :transactions,
    through: :invoices
  has_many :customers,
    through: :invoices

  validates :name, presence: true, uniqueness: true

  def self.total_revenue(merchant_id, date)
    if date.nil?
      find(merchant_id)
        .invoices
        .joins(:transactions)
        .merge(Transaction.successful)
        .joins(:invoice_items)
        .sum("quantity * unit_price")
    else
      find(merchant_id)
        .invoices
        .joins(:transactions)
        .where(created_at: date)
        .merge(Transaction.successful)
        .joins(:invoice_items)
        .sum("quantity * unit_price")
    end
  end

end
