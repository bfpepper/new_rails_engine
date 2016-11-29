FactoryGirl.define do
  factory :item do
    name
    description
    unit_price
    merchant 
  end

  sequence :name do |n|
    "name #{n}"
  end

  sequence :description do |n|
    "description #{n}"
  end

  sequence :unit_price do |n|
    "#{n.to_f}"
  end

end
