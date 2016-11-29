FactoryGirl.define do
  factory :transaction do
    invoice Invoice.create(status:"failed", merchant_id: 1, customer_id: 1)
    credit_card_number
    credit_card_expiration_date
    result "success"
  end
  sequence :credit_card_number do |n|
    "Card ##{n}"
  end
  sequence :credit_card_expiration_date do |n|
    "11/#{n}"
  end
end
