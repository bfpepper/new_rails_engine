class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :transactions,
    through: :invoices
  has_many :customers,
    through: :invoices


  validates :name, presence: true, uniqueness: true
end
