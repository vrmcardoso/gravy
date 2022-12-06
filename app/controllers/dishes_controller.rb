class DishesController < ApplicationController

  def index

    @dishes = Dish.all
    @restaurants = Restaurant.all

    if params[:query].present?
      result = params[:query].capitalize
      dishes = Dish.all
      cuisine
      food_type
      name
      if @cuisines.include? "#{result}"
        cuisine_dishes = dishes.select { |dish| dish.category.cuisine == params[:query] }
        cuisine_dishes.sort_by { |dish| dish.sum_points}.reverse
        raise
      elsif @food_types.include? "#{result}"
        food_type_dishes = dishes.select { |dish| dish.category.food_type == params[:query] }
        food_type_dishes.sort_by { |dish| dish.sum_points}.reverse
        raise
      elsif @names.include? "#{result}"
        name_dishes = dishes.select { |dish| dish.category.name == params[:query] }
        name_dishes.sort_by { |dish| dish.sum_points}.reverse
        raise
      else
        "Wrong input"
        raise
      end
    end
    @sorted_francesinhas = sort_dishes_by_name("Francesinha")
    @sorted_sushi = sort_dishes_by_food_type("Sushi")
    @sorted_pizzas = sort_dishes_by_food_type("Pizza")
  end

  def cuisine
    @cuisines = []
    @categories = Category.all
    @categories.each do |category|
      @cuisines << category.cuisine
    end
    return @cuisines
  end

  def food_type
    @food_types = []
    @categories = Category.all
    @categories.each do |category|
      @food_types << category.food_type
    end
    return @food_types
  end

  def name
    @names = []
    @categories = Category.all
    @categories.each do |category|
      @names << category.name
    end
    return @names
  end

  # def index
  #   if params[:query].present?
  #     @dishes = Dish.global_search(params[:query])
  #     @restaurants = Restaurant.global_search(params[:query])
  #   else
  #     @dishes = Dish.all
  #     @restaurants = Restaurant.all
  #   end
  # end

  def show
    @dish = Dish.find(params[:id])
    @restaurant = Restaurant.find(@dish.restaurant_id)
    @restaurant_categories = RestaurantCategory.where("restaurant_id = ?", @restaurant.id)
    @categories = []
    @restaurant_categories.each do |category|
      @categories << Category.find(category.category_id)
    end
    @cuisines = []
    @categories.each do |category|
      @cuisines << category.cuisine
    end

    @rank = current_user.ranks.find_by(dish: @dish)
    unless @rank.present?
      @rank = Rank.new
    end
    @cuisines = @cuisines.uniq
    @markers =
      [{
        lat: @dish.restaurant.latitude,
        lng: @dish.restaurant.longitude,
        image_url: helpers.asset_url("IconGrande.png")
      }]

    @cuisines.each do |cuisine|
      rank_restaurant(@restaurant, cuisine)
    end
  end

  private

  def sort_dishes_by_food_type(food_type)
    @categories = Category.where("food_type = ?", food_type)
    @sorted_dishes = []
    @categories.each do |category|
      cat_dishes = Dish.where("category_id = ?", category.id)
        cat_dishes.each do |dish|
          @sorted_dishes << dish
        end
    end
    @sorted_dishes.sort_by { |dish| dish.sum_points }
  end

  def sort_dishes_by_cuisine(cuisine)
    @categories = Category.where("cuisine = ?", cuisine)
    @sorted_dishes = []
    @categories.each do |category|
      cat_dishes = Dish.where("category_id = ?", category.id)
        cat_dishes.each do |dish|
          @sorted_dishes << dish
        end
    end
    @sorted_dishes.sort_by { |dish| dish.sum_points }
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
    @sorted_dishes.sort_by { |dish| dish.sum_points }
  end

  def rank_restaurant(restaurant, cuisine)
    all_restaurants = Restaurant.all
    target_restaurants = all_restaurants.select { |rest| rest.categories.each { |cat| cat.cuisine == cuisine }}
    all_restaurant_categories = RestaurantCategory.all
    target_categories = Category.where("cuisine = ?", cuisine)
    target_restaurant_categories = all_restaurant_categories.select { |rest_cat| target_categories.include?(rest_cat.category) }
    

  end
  # def cuisine
  #   @dishes = = Dish.global_search(params[:query])
  # end

end
