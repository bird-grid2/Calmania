json.array! @user do |user|
  json.id user.id
  json.user_sign_in current_user
end
