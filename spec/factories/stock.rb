FactoryGirl.define do
  factory :stock do
    name { Faker::Company.bs }
    bearer { FactoryGirl.build(:bearer) }
    market_price { FactoryGirl.build(:market_price) }

    trait :demo do
      name { "Company Stock" }
      bearer { FactoryGirl.build(:bearer, :demo) }
      market_price { FactoryGirl.build(:market_price, :demo) }
    end
  end
end
