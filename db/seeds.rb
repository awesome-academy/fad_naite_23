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

5.times do |n|
  name = Faker::Restaurant.type
  description = Faker::Food.description
  Category.create!(name: name,
    description: description)
end

categories = Category.all
types = ["food", "drink"]
10.times do |n|
  name = Faker::Food.dish
  description = Faker::Food.description
  price = Faker::Number.number(3)
  picture = "http://placehold.it/460x250/e67e22/ffffff&text=HTML5"
  product_type = types.sample
  categories.each do |category|
    category.products.create!(name: name,
    description: description,
    price: price,
    picture: picture,
    product_type: product_type)
  end
end
