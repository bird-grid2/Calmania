FactoryBot.define do
  factory :menu do
    menu                {'サンプルA'}
    names               {[1, 2, 3]}
    masses              {4500}
    total_protain       {123.4}
    total_fat           {567.9}
    total_carbohydrate  {4501.3}
  end
end