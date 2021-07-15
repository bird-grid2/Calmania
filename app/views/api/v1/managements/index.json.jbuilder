json.array! @period do |log|
  json.id log.id
  json.date log.date
  json.weight log.weight
  json.bfp log.bfp
  json.total_cal log.total_cal
  json.description log.description
  json.menu_numbers log.menu_numbers
  json.user_id log.user_id
  json.user_sign_in current_user
end
