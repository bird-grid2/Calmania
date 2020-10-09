FactoryBot.define do
  factory :log do
    date          { "2020/10/2" }
    weight        { 75.3 }
    bfp           { 25.1 }
    total_cal     { 1503.5 }
    description   { 'テキスト' }
    menu_numbers  { [1, 2, 3] }
    association :user
  end
end
