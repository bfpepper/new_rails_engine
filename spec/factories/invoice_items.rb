FactoryGirl.define do
  factory :invoice_item do
    association :item
    association :invoice
    quantity
    unit_price
  end

  sequence :quantity do |n|
    "#{n}"
  end

end
