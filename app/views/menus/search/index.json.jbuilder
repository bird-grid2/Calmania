json.array! @menus do |menu|
  json.id menu.id
  json.menu menu.menu
  json.masses menu.masses
  json.total_protain menu.total_protain
  json.total_fat menu.total_fat
  json.total_carbohydrate menu.total_carbohydrate
end