FactoryBot.define do
  factory :menu_item do
    name { "Burger" }
    association :menu
  end
end
