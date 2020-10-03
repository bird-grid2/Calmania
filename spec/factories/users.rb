FactoryBot.define do
  factory :user do
    nickname:                 {'トリ'}
    email:                    {'abc@yahoo.co.jp'}
    encryped_password:        {'000000'}
    height:                   {172.5}
    ideal_protain_rate:       {3}
    ideal_fat_rate:           {4}
    ideal_carbohydrate_rate:  {3}
    target_cal:               {1200}
  end
end