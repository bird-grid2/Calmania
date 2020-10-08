FactoryBot.define do
  factory :menu do
    b {'あいうえお'}
    names { [1, 2, 3] }
    masses { [200, 100, 300] }
    total_protain { 123.4 }
    total_fat { 567.9 }
    total_carbohydrate { 4501.3 }
  end
end
