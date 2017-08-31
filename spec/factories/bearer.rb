FactoryGirl.define do
  factory :bearer do
    name { Faker::Name.name }

    trait :demo do
      name "Me"
    end

    trait :demo_second do
      name "Jake Brady"
    end
  end
end
