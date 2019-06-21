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
types = [Settings.food, Settings.drink]
10.times do |n|
  categories.each do |category|
    name = Faker::Food.dish
    description = Faker::Food.description
    price = Faker::Number.number(3)
    picture = Pathname.new(Rails.root.join("app/assets/images/test.png")).open
    product_type = types.sample
    rating = Faker::Number.between(1, 5)
    category.products.create!(name: name,
    description: description,
    price: price,
    picture: picture,
    product_type: product_type,
    average_rating: rating)
  end
end

users = User.all.take(6)
products = Product.all.take(6)
users.each_with_index do |user, idx|
  order = user.orders.create! receiver_name: user.name, delivery_address: user.address,
    receiver_phone_number: user.phone_number
  order.order_lists.create! product_id: products[idx].id, quantity: 1,
    unit_sold_price: products[idx].price
end
