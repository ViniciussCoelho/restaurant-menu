FactoryBot.define do
  factory :menu do
    name { "Default Menu" }
    association :restaurant
  end
end
