FactoryGirl.define do
  factory :market_price do
    value_cents { Faker::Number.number(4) }
    currency "EUR"

    trait :demo do
      value_cents 1939
      currency "EUR"
    end
  end

  factory :market_price_2, class: MarketPrice do
    value_cents { Faker::Number.number(4) }
    currency "USD"
  end
end
