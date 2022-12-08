restaurant_categories = RestaurantCategory.all
sum = 0
restaurant_categories.each do |rest_cat|
  rest_cat.restaurant.dishes.each do |dish|
    rest_cat.update(points: dish.sum_points)
  end
end
