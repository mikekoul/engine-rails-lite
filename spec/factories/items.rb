FactoryBot.define do
  factory :item do
    association :merchant, factory: :merchant
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Commerce.price }
  end
end