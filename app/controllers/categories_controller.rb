class CategoriesController < ApplicationController


  def top
    @dishes = Dish.all
    @restaurants = Restaurant.all
    @categories = Category.all
    @restaurants_categories = RestaurantCategory.all

    @results = []
    if params[:query].present?
      result = params[:query].capitalize
      @type = params[:type]
      dishes = Dish.all
      cuisine
      food_type
      name
      if @type == "Dish"
        if @names.include? "#{result}"
          name_dishes = dishes.select { |dish| dish.category.name == result }
          @results = name_dishes.sort_by { |dish| dish.sum_points}.reverse
        elsif @food_types.include? "#{result}"
          food_type_dishes = dishes.select { |dish| dish.category.food_type == result }
          @results = food_type_dishes.sort_by { |dish| dish.sum_points}.reverse
        elsif @cuisines.include? "#{result}"
          cuisine_dishes = dishes.select { |dish| dish.category.cuisine == result }
          @results = cuisine_dishes.sort_by { |dish| dish.sum_points}.reverse
        else
          "Wrong input"
        end
      else # type == "Restaurant"
        if @names.include? "#{result}"
          @target_id = @categories.find { |category| category.name == result }.id
          all_target_category_restaurants = @restaurants_categories.select { |res_cat| res_cat.category_id == @target_id }
          target_restaurants = []
          all_target_category_restaurants.each do |res_cat|
            target_restaurants << { restaurant: res_cat.restaurant_id, points: res_cat.points }
          end
          results = target_restaurants.sort_by { |result| result[:points] }.reverse
          @results = results.map { |result| Restaurant.find(result[:restaurant]) }
        elsif @food_types.include? "#{result}"
          @target_id = @categories.find { |category| category.food_type == result }.id
          all_target_category_restaurants = @restaurants_categories.select { |res_cat| res_cat.category_id == @target_id }
          target_restaurants = []
          all_target_category_restaurants.each do |res_cat|
            target_restaurants << { restaurant: res_cat.restaurant_id, points: res_cat.points }
          end
          results = target_restaurants.sort_by { |result| result[:points] }.reverse
          @results = results.map { |result| Restaurant.find(result[:restaurant]) }
        elsif @cuisines.include? "#{result}"
          @target_id = @categories.find { |category| category.cuisine == result }.id
          all_target_category_restaurants = @restaurants_categories.select { |res_cat| res_cat.category_id == @target_id }
          target_restaurants = []
          all_target_category_restaurants.each do |res_cat|
            target_restaurants << { restaurant: res_cat.restaurant_id, points: res_cat.points }
          end
          results = target_restaurants.sort_by { |result| result[:points] }.reverse
          @results = results.map { |result| Restaurant.find(result[:restaurant]) }
        else
          "Wrong input"
        end
      end
    end

  end


  private

  def cuisine
    @cuisines = []
    @categories = Category.all
    @categories.each do |category|
      @cuisines << category.cuisine
    end
    @cuisines = @cuisines.uniq
    return @cuisines
  end

  def food_type
    @food_types = []
    @categories = Category.all
    @categories.each do |category|
      @food_types << category.food_type
    end
    @food_types = @food_types.uniq
    return @food_types
  end

  def name
    @names = []
    @categories = Category.all
    @categories.each do |category|
      @names << category.name
    end
    @names = @names.uniq
    return @names
  end

end
