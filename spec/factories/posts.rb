FactoryBot.define do
  factory :post do
    tweet {Faker::Lorem.sentence}
    image {Faker::Lorem.sentence}
    association :user
  end
end
