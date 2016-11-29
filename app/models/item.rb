class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoices_items
  has_many :invoices,
    through: :invoices_items
  validates :name,
            :description,
            :unit_price,
            :merchant_id, presence: true
end
