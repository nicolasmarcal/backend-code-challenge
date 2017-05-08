FactoryGirl.define do
  factory :course do
    distance 1
    origin_location { FactoryGirl.create(:location) }
    destiny_location { FactoryGirl.create(:location) }
  end
end
