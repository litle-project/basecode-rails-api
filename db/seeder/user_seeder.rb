require 'bcrypt'

include BCrypt

User.destroy_all

User.create([
  {
    name: "Admin",
    email: "admin@ruby.com",
    password: BCrypt::Password.create("123456"),
    phone_number: "08123456"
  },
  {
    name: "Superadmin",
    email: "superadmin@ruby.com",
    password: BCrypt::Password.create("123456"),
    phone_number: "08123789"
  }
])