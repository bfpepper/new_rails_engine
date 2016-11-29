FactoryGirl.define do
  factory :invoice do
    customer Customer.create
    merchant Merchant.create
    status
  end

  sequence :status do |n|
    "status #{n}"
  end
  
end
