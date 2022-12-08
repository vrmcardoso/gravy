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
    @top_dishes = @restaurant.dishes.sort_by { |dish| dish.sum_points }
    @top_dish = @top_dishes.reverse[0]

    @main_dish_rank = rank_dish(@top_dish)
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
    rest_cats = restaurant.restaurant_categories

    cats_points = []
    rest_cats.each do |rest_cat|
      cats_points << {category_id: rest_cat.category_id, points: rest_cat.points}
    end
    all_rest_cats = RestaurantCategory.all
    all_target_rest_cats = []
    all_rest_cats.each do |rest_cat|
      cats_points.each do |cat_points|
        if rest_cat.category_id == cat_points[:category_id]
          restaurant_points_update(restaurant, rest_cat.category_id)
          all_target_rest_cats << rest_cat
        end
      end
    all_sorted = all_target_rest_cats.sort_by { |rest_cat| rest_cat.points }
    all_sorted = all_sorted.reverse
    @sorted_rest_cats = []
    rest_cats.each do |rest_cat|
      all_sorted.each do |target_cat|
        if rest_cat.category_id == target_cat.category_id
          @sorted_rest_cats << {id: rest_cat.category_id, categories: all_sorted.select { |cat| cat.category_id == rest_cat.category_id }}
        end
      end
    end
    @sorted_rest_cats = @sorted_rest_cats.uniq
    @positions = []
    @sorted_rest_cats.each do |sorted_cat|
      @positions << {category_id: sorted_cat[:id], position: (sorted_cat[:categories].find_index { |category| category.restaurant_id == params[:id].to_i } ) }
    end
  end


    # restaurant_categories = RestaurantCategory.all
    # target_restaurant_categories = restaurant_categories.select { |res_cat| res_cat.restaurant_id == restaurant.id }
    # target_categories = []
    # target_restaurant_categories.each do |res_cat|
    #   target_categories << { category: res_cat.category_id, points: res_cat.points }
    # end
    # target_categories = target_categories.uniq
    # @position = []
    # target_categories.each do |category|
    #   all_target_category_restaurants = restaurant_categories.select { |res_cat| res_cat.category_id == category[:category] }
    #   raise
    #   target_restaurants = []
    #   all_target_category_restaurants.each do |res_cat|
    #     target_restaurants << { restaurant: res_cat.restaurant_id, points: res_cat.points }
    #   end
    #   target_restaurant_sort = target_restaurants.sort_by { |result| result[:points] }.reverse
    #   target_restaurant_sort = target_restaurant_sort.map { |result| Restaurant.find(result[:restaurant]) }
    #   @position << { category: category[:category], position: (target_restaurant_sort.find_index(Restaurant.find(restaurant.id)) + 1) }
    #   @position = @position.uniq
    # end
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
    @sorted_dishes = @sorted_dishes.sort_by { |dish| dish.sum_points }
    @sorted_dishes = @sorted_dishes.reverse
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

  def restaurant_points_update(restaurant, category)
    @target_restaurant_category = restaurant.category(category)
    sum = 0
    restaurant.dishes.each do |dish|
      if dish.category == category
        sum += dish.sum_points
      end
    end
    @target_restaurant_category.update(points: sum)
  end
end
