FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :person do
    name "Marsh, Kevin"
    email
  end
end
