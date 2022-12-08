restaurant_categories = RestaurantCategory.all
sum = 0
restaurant_categories.each do |rest_cat|
  rest_cat.restaurant.dishes.each do |dish|
    if dish.category_id == rest_cat.category_id
      rest_cat.update(points: dish.sum_points)
    end
  end
end
