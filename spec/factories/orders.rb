FactoryBot.define do
  factory :destination_order do
    shipping_area_id { Faker::Number.between(from: 2, to: 48) }
    city { Faker::Address.city }
    house_number { Faker::Address.street_address }
    building_number { Faker::Address.building_number }
    phone_number { Faker::Number.number(digits: 11) }
    token { Faker::Internet.password(min_length: 32, max_length: 32) }
    postal_code { '123-4567' }
    association :user
    association :item
  end
end
