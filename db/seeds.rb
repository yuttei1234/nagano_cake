# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Customer.create!(
  first_name: first_name,
  last_name: last_name,
  kana_first_name: kana_first_name,
  kana_last_name: kana_last_name,
  postal_code: postal_code,
  address: address,
  phone_number: phone_number,
  email: email,
  password: 'password',
  password_confirmation: 'password'
  )

Admin.create!(email: "admin@example.jp",
              password:  "password",
              password_confirmation: "password"
              )