FactoryGirl.define do
  factory :transaction do
    association :invoice
    credit_card_expiration_date
    credit_card_number
    result "success"
  end
  sequence :credit_card_number do |n|
    "#{n}"
  end
  sequence :credit_card_expiration_date do |n|
    "11/#{n}"
  end
end
