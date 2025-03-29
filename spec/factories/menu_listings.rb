FactoryBot.define do
  factory :menu_listing do
    menu
    menu_item
    price { "9.99" }
    description { "MyText" }
  end
end
