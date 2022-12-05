class RestaurantsController < ApplicationController

  def index
    @restaurant = Restaurant.find(params[:id])
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @restaurant_categories = RestaurantCategory.where("restaurant_id = ?", @restaurant.id)
    @categories_ranks = []
    @restaurant_categories.each do |rest_cat|
      @categories_ranks << {name: Category.find(rest_cat.category_id).name, points: rest_cat.points}
    end

    @markers =
      [{
        lat: @restaurant.latitude,
        lng: @restaurant.longitude,
        image_url: helpers.asset_url("IconGrande.png")
      }]
  end

  private

  def points(restaurant)
    @restaurant_categories = RestaurantCategory.where("restaurant_id = ?", restaurant.id)
    sum = 0
    @restaurant_categories.each do |rest_category|
      @restaurant.dishes.each do |dish|
        sum += dish.sum_points
      end
      rest_category.update(points: sum)
    end
  end
end
