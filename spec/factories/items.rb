FactoryBot.define do
  factory :item do
    name                    { Faker::Lorem.word }
    description             { Faker::Lorem.sentence }
    price                   { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id             { Faker::Number.between(from: 1, to: 10) }
    condition_id            { Faker::Number.between(from: 1, to: 6) }
    shipping_cost_id        { Faker::Number.between(from: 1, to: 2) }
    prefecture_id           { Faker::Number.between(from: 1, to: 47) }
    shipping_duration_id    { Faker::Number.between(from: 1, to: 3) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
