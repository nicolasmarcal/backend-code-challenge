FactoryGirl.define do
  factory :location do
    sequence(:name, 'a') { |n| Faker::Name.first_name + n.to_s }
  end
end
