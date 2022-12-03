# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'open-uri'

puts "Cleaning database..."
Restaurant.destroy_all
Category.destroy_all
User.destroy_all

puts "Creating restaurants and dishes..."

user1 = User.create(
  email: "vasco@gmail.com",
  password: "111111",
  first_name: "Vasco",
  last_name: "Cardoso",
  address: "Le Wagon Lisboa"
)

user2 = User.create(
  email: "miguel@gmail.com",
  password: "111111",
  first_name: "Miguel",
  last_name: "Silva",
  address: "Rua Marcos Portugal, Lisboa Portugal"
)

user3 = User.create(
  email: "ze@gmail.com",
  password: "111111",
  first_name: "Ze",
  last_name: "Manel",
  address: "Arroios"
)

category1 = Category.create(
  name: "Spaghetti Bolognese",
  cuisine: "Italian",
  food_type: "Pasta"
)
photo_url = 'https://res.cloudinary.com/dmndhddgf/image/upload/v1669905623/development/bollognese_in1elq.jpg'
file = URI.open(photo_url)
category1.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category1.save

category2 = Category.create(
  name: "Pizza Margherita",
  cuisine: "Italian",
  food_type: "Pizza"
)
photo_url = 'https://res.cloudinary.com/dmndhddgf/image/upload/v1669905689/development/pizza_marguerita_qatjha.jpg'
file = URI.open(photo_url)
category2.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category2.save

category3 = Category.create(
  name: "Francesinha",
  cuisine: "Portuguese"
)
photo_url = 'https://res.cloudinary.com/dmndhddgf/image/upload/v1669905810/development/francesinha_uy2g1l.webp'
file = URI.open(photo_url)
category3.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category3.save

category4 = Category.create(
  name: "Sushi to Sashimi",
  cuisine: "Asian",
  food_type: "Sushi"
)
photo_url = 'https://res.cloudinary.com/dmndhddgf/image/upload/v1669905931/development/sushi_to_sashimi_ep7u3k.jpg'
file = URI.open(photo_url)
category4.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category4.save

category5 = Category.create(
  name: "pinnekjøtt",
  cuisine: "Norwegian",
  food_type: "Christmas"
)
photo_url = 'https://res.cloudinary.com/dmndhddgf/image/upload/v1669906035/development/pinnekj%C3%B8tt_ftkhh2.jpg'
file = URI.open(photo_url)
category5.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category5.save

10.times do
  Restaurant.create(
    name: Faker::Restaurant.name,
    description: Faker::Restaurant.description,
    address: "16 Villa Gaudelet, Paris"
  )
    5.times do
      dish = Dish.create(
        name: Faker::Food.dish,
        recipe: Faker::Food.description,
        sum_points: rand(0..250),
        milk: [true, false].sample,
        eggs: [true, false].sample,
        peanuts: [true, false].sample,
        shellfish: [true, false].sample,
        wheat: [true, false].sample,
        soy: [true, false].sample,
        restaurant_id: Restaurant.last.id,
        category_id: rand(category1.id..category5.id),
      )
      photo_url = 'https://res.cloudinary.com/dmndhddgf/image/upload/v1669803039/development/food1_w75bhq.jpg'
      file = URI.open(photo_url)
      dish.photo.attach(io: file, filename: "food", content_type: "image/jpg")
      dish.save
    end
end

dish_first = Dish.first
dish_last = Dish.last
25.times do
  rank = Rank.create(
    ranking: rand(0..250),
    user_id: rand(user1.id..user3.id),
    dish_id: rand(dish_first.id..dish_last.id)
  )
  rank.save
end

restaurant_first = Restaurant.first
restaurant_last = Restaurant.last
10.times do
  restaurant_category = RestaurantCategory.create(
    category_id: rand(category1.id..category5.id),
    restaurant_id: rand(restaurant_first.id..restaurant_last.id),
    points: rand(0..500)
  )
  restaurant_category.save
end
