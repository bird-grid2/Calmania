FactoryBot.define do
  factory :log do
    date          {  }
    weight        { 75.3 }
    bfp           { 25.1 }
    total_cal     { 1503.5 }
    description   { 'テキスト' }
    menu_numbers  { [1, 2, 3] }
    user_id       {  }
  end
end
