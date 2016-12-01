class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :transactions,
    through: :invoices
  has_many :customers,
    through: :invoices
  has_many :invoice_items,
    through: :invoices

  def total_revenue(date)
    if date.nil?
        invoices.joins(:transactions, :invoice_items)
        .merge(Transaction.successful)
        .sum("quantity * unit_price")
    else
        invoices.joins(:transactions, :invoice_items)
        .where(created_at: date)
        .merge(Transaction.successful)
        .sum("quantity * unit_price")
    end
  end

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .group("merchants.id")
    .order("revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .select("merchants.*, sum(invoice_items.quantity) AS items")
    .group("merchants.id")
    .order("items DESC")
    .limit(quantity)
  end

  def favorite_customer
    customers.joins(:transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("count(transactions) DESC").first
  end

  def self.all_revenue(date)
    joins(invoices: [:invoice_items, :transactions]).merge(Transaction.successful).where(invoices: {created_at: date}).sum("quantity * unit_price")
  end

end
