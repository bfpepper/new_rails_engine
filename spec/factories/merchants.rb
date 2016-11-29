FactoryGirl.define do
  factory :merchant do
    name
  end
  sequence :name do |n|
    "Merchant #{n}"
  end
end
