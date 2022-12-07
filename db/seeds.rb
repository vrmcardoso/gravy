# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
puts "Starting..."








Rank.destroy_all

dishes = Dish.all
restaurants = Restaurant.all
puts "writing dish recipes"
dishes.each do |dish|
  dish.recipe = Faker::Food.description
  dish.save
end
puts "writing restaurant descriptions"
restaurants.each do |restaurant|
  restaurant.description = Faker::Restaurant.description
  restaurant.save
end

puts "completed"
