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
    rank_restaurant(@restaurant)
    @cuisines = []
    @categories = []
    @restaurant_categories.each do |category|
      @categories << Category.find(category.category_id)
    end
    @categories.each do |category|
      @cuisines << category.cuisine
    end
    @cuisines = @cuisines.uniq
    @top_dish = @restaurant.dishes.sort_by { |dish| dish.sum_points }.reverse[0]
    rank_dish(@top_dish)
    sorting
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

  def rank_restaurant(restaurant)
    restaurant_categories = RestaurantCategory.all
    target_restaurant_categories = restaurant_categories.select { |res_cat| res_cat.restaurant_id == restaurant.id }
    target_categories = []
    target_restaurant_categories.each do |res_cat|
      target_categories << { category: res_cat.category_id, points: res_cat.points }
    end
    target_categories = target_categories.uniq
    @position = []
    target_categories.each do |category|
      all_target_category_restaurants = restaurant_categories.select { |res_cat| res_cat.category_id == category[:category] }
      target_restaurants = []
      all_target_category_restaurants.each do |res_cat|
        target_restaurants << { restaurant: res_cat.restaurant_id, points: res_cat.points }
      end
      target_restaurant_sort = target_restaurants.sort_by { |result| result[:points] }.reverse
      target_restaurant_sort = target_restaurant_sort.map { |result| Restaurant.find(result[:restaurant]) }
      @position << { category: category[:category], position: (target_restaurant_sort.find_index(Restaurant.find(restaurant.id)) + 1) }
      @position = @position.uniq
    end
  end

  def sort_dishes_by_name(name)
    @categories = Category.where("name = ?", name)
    @sorted_dishes = []
    @categories.each do |category|
      cat_dishes = Dish.where("category_id = ?", category.id)
        cat_dishes.each do |dish|
          @sorted_dishes << dish
        end
    end
    @sorted_dishes.sort_by { |dish| dish.sum_points }.reverse
  end

  def rank_dish(dish)
    sorted_dishes = sort_dishes_by_name(dish.category.name)
    @dish_rank = (sorted_dishes.find_index(Dish.find(dish.id)) + 1)
  end

  def sorting
    dishes = @restaurant.dishes
    @dish_ranks = []
    dishes.each do |dish|
      dish_rank = {dish: dish, rank: rank_dish(dish)}
      @dish_ranks << dish_rank
    end
  end
end
