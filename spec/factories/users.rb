FactoryBot.define do
  factory :user do
    nickname                { Faker::Internet.username + "太郎" }
    email                   { Faker::Internet.email }
    password                { Faker::Alphanumeric.alphanumeric(number: 6) }
    password_confirmation   { password }
    last_name               { "鬼々ヶ島" }
    first_name              { "モモたろー" }
    last_kana               { "オニオニガシマ" }
    first_kana              { "モモタロー" }
    birthday                { Faker::Date.between(from: "1930-01-01", to: 5.year.ago) }
  end
end
