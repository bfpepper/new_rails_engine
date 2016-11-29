FactoryGirl.define do
  factory :invoice do
    customer
    merchant
    status
  end

  sequence :status do |n|
    "status #{n}"
  end

end
