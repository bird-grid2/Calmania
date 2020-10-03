FactoryBot.define do
  factory :food do
    food               { 'サンプルA' }
    protain_rate       { 0.12345 }
    fat_rate           { 0.67890 }
    carbohydrate_rate  { 0.12345 }
  end
end