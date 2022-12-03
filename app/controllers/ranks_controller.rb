class RanksController < ApplicationController

  def show
    @dishes = Dish.all
    @categories = Category.all
    @ranks = Rank.all
    @restaurants = Restaurant.all
    @restaurants_categories = RestaurantCategory.all

    # @target_restaurant = @restaurants.last
    # @restaurant_dishes = @target_restaurant.dishes
    # @restaurant_categories = []
    # @restaurant_dishes.each do |dish|
    #   @restaurant_categories << dish.category
    # end
    # @restaurant_categories = @restaurant_categories.uniq

    target_categories = []
    target_restaurant_categories = @restaurants_categories.select { |res_cat| res_cat.restaurant_id == 4 }
    target_restaurant_categories.each do |res_cat|
      target_categories << { category: res_cat.category_id, points: res_cat.points }
    end
    target_categories = target_categories.uniq

    # all restaurants for a specific category
    all_target_category_restaurants = @restaurants_categories.select { |res_cat| res_cat.category_id == 2 }
    target_restaurants = []
    all_target_category_restaurants.each do |res_cat|
      target_restaurants << { restaurant: res_cat.restaurant_id, points: res_cat.points}
    end

    # rank of restaurant
    target_restaurant_sort = target_restaurants.sort_by { |result| result[:points] }.reverse
    @target_restaurant_sort = target_restaurant_sort.map { |result| Restaurant.find(result[:restaurant]) }


    target_restaurant = @restaurants.find { |restaurant| restaurant.id = 4}


    raise

  end
end
