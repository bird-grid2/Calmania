json.data @resource
json.groups @resource.groups do |group|
  json.id group.id
  json.nickname group.nickname
  json.email group.email
  json.password group.password
end
