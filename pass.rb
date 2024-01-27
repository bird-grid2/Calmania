require 'bcrypt'

plain_password = '65oihue8'
hashed_password = BCrypt::Password.create(plain_password)

print(hashed_password)