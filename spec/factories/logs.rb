FactoryBot.define do
  factory :log do
    date:          {'2020/10/02'}
    weight:        {75.0}
    bfp:           {25.1}
    total_cal:     {1503.5}
    description:   {'テキスト'}
    menu_numbers:  {[1, 2, 3]}
    user_id:       {1}
  end
end