FactoryBot.define do
  factory :order_address do
    token               { 'tok_' + Faker::Alphanumeric.alphanumeric(number: 28) }
    postcode            { '111-0023' }
    prefecture_id       { Faker::Number.between(from: 1, to: 47) }
    city                { '世田谷区玉川' }
    block               { '1-23-4' }
    building            { 'ハウスAnnex506' }
    phone               { Faker::Number.leading_zero_number(digits: 11) }
  end
end
