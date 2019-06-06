User.create!(name: "admin",
  email: "admin@admin.com",
  phone_number: "123456789",
  address: "Nha tao",
  password: "123456",
  password_confirmation: "123456",
  admin: true)

99.times do |n|
name = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
address = Faker::Address.street_address
phone_number = Faker::PhoneNumber.cell_phone
password = "password"
User.create!(name: name,
    email: email,
    phone_number: phone_number,
    address: address,
    password: password,
    password_confirmation: password)
end
