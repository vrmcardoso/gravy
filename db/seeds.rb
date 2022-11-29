# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

puts "Cleaning database..."
Restaurant.destroy_all
Category.destroy_all

puts "Creating restaurants and dishes..."

user = User.new(
  email: "vasco@gmail.com",
  password: "111111",
  first_name: "Vasco",
  last_name: "Cardoso",
  address: "Le Wagon Lisboa"
)
category1 = Category.create(
  name: "Spaghetti Bolognese",
  cuisine: "Italian",
  food_type: "Pasta"
)

category2 = Category.create(
  name: "Pizza Margherita",
  cuisine: "Italian",
  food_type: "Pizza"
)

category3 = Category.create(
  name: "Francesinha",
  cuisine: "Portuguese"
)

category4 = Category.create(
  name: "Sushi to Sashimi",
  cuisine: "Asian",
  food_type: "Sushi"
)

category5 = Category.create(
  name: "pinnekjøtt",
  cuisine: "Norwegian",
  food_type: "Christmas"
)


10.times do
  Restaurant.create(
    name: Faker::Restaurant.name,
    description: Faker::Restaurant.description,
    address: "16 Villa Gaudelet, Paris"
  )
    10.times do
      Dish.create(
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
        category_id: rand(category1.id..category5.id)
      )
    end
end
