class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  validates :customer_id, :merchant_id, :status, presence: true
end
