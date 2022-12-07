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
    @categories = @categories.uniq
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

    rank_restaurant(@restaurant)
    @dish_category = Category.find(@dish.category_id)
    rank_dish(@dish, @dish_category)
    sort_dishes_by_name(@dish.category.name)
    @dropdown_size = 1
    @sorted_dishes.each do |dish|
      if dish.rank(current_user)
        @dropdown_size += 1
      end
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
    @sorted_dishes.sort_by { |dish| dish.sum_points }.reverse
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
    @sorted_dishes.sort_by { |dish| dish.sum_points }.reverse
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

  def rank_dish(dish, category)
    sorted_dishes = sort_dishes_by_name(category.name)
    @dish_rank = (sorted_dishes.find_index(Dish.find(dish.id)) + 1)
  end
  # def cuisine
  #   @dishes = = Dish.global_search(params[:query])
  # end

end
