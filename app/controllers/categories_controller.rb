class CategoriesController < ApplicationController


  def top
    @dishes = Dish.all
    @restaurants = Restaurant.all
    @categories = Category.all
    @restaurants_categories = RestaurantCategory.all

    @results = []
    if params[:query].present?
      result = params[:query].downcase
      @type = params[:type]
      dishes = Dish.all
      cuisine
      food_type
      name
      restaurant
      if @type == "Dish"
        if @restaurants_name.include? result
          restaurant_id = @restaurants.find { |restaurant| restaurant.name.downcase == result }.id
          rest_dishes = dishes.select { |dish| dish.restaurant_id == restaurant_id }
          @results = rest_dishes.sort_by { |dish| dish.sum_points}.reverse
        elsif @names.include? result
          name_dishes = dishes.select { |dish| dish.category.name.downcase == result }
          @results = name_dishes.sort_by { |dish| dish.sum_points}.reverse
        elsif @food_types.include? result

          food_type_dishes = dishes.select { |dish| dish.category.food_type.downcase == result unless dish.category.food_type.nil? }
          @results = food_type_dishes.sort_by { |dish| dish.sum_points}.reverse
        elsif @cuisines.include? result
          @cuisine_dishes = dishes.select { |dish| dish.category.cuisine.downcase == result }
          @results = @cuisine_dishes.sort_by { |dish| dish.sum_points}.reverse
        else
          redirect_back_or_to root_path, notice: "No results for your input"
        end
      else # type == "Restaurant"
        if @restaurants_name.include? result
          restaurant_id = @restaurants.find { |restaurant| restaurant.name.downcase == result }.id
          rest_dishes = dishes.select { |dish| dish.restaurant_id == restaurant_id }
          rest_dishes_sort = rest_dishes.sort_by { |dish| dish.sum_points}.reverse
          category_of_first_dish = rest_dishes_sort[0].category.cuisine.downcase
          rel_categories = @categories.select { |category| category.cuisine.downcase == category_of_first_dish }
          rel_categories_id = []
          rel_categories.each do |rel_cat|
            rel_categories_id << rel_cat.id
          end

          rest_cat = []
          rel_categories_id.each do |rel_cat_id|
            rest_cat << @restaurants_categories.filter { |res_cat| res_cat.category_id == rel_cat_id }
          end

          @final_result = @restaurants.find { |restaurant| restaurant.name.downcase == result }.id
          rest_ids = []
          rest_ids << @final_result
          rest_cat.each do |res_cat_one|
            res_cat_one.each do |res_cat_two|
              rest_ids << res_cat_two.restaurant_id
            end
          end
          rest_ids = rest_ids.uniq

          final_restaut = []

          rest_ids.each do |id|
            final_restaut << @restaurants.select { |restaurant| restaurant.id == id }
          end
          @results = final_restaut.flatten

        elsif @names.include? result
          @target_id = @categories.find { |category| category.name.downcase == result }.id
          all_target_category_restaurants = @restaurants_categories.select { |res_cat| res_cat.category_id == @target_id }
          target_restaurants = []
          all_target_category_restaurants.each do |res_cat|
            target_restaurants << { restaurant: res_cat.restaurant_id, points: res_cat.points }
          end
          results = target_restaurants.sort_by { |result| result[:points] }.reverse
          @results = results.map { |result| Restaurant.find(result[:restaurant]) }
        elsif @food_types.include? result
          @target_id = @categories.find { |category| category.food_type.downcase == result if !category.food_type.nil?  }.id
          all_target_category_restaurants = @restaurants_categories.select { |res_cat| res_cat.category_id == @target_id }
          target_restaurants = []
          all_target_category_restaurants.each do |res_cat|
            target_restaurants << { restaurant: res_cat.restaurant_id, points: res_cat.points }
          end
          results = target_restaurants.sort_by { |result| result[:points] }.reverse
          @results = results.map { |result| Restaurant.find(result[:restaurant]) }
        elsif @cuisines.include? result
          @target_id = @categories.find { |category| category.cuisine.downcase == result }.id
          all_target_category_restaurants = @restaurants_categories.select { |res_cat| res_cat.category_id == @target_id }
          target_restaurants = []
          all_target_category_restaurants.each do |res_cat|
            target_restaurants << { restaurant: res_cat.restaurant_id, points: res_cat.points }
          end
          results = target_restaurants.sort_by { |result| result[:points] }.reverse
          @results = results.map { |result| Restaurant.find(result[:restaurant]) }
        else
          redirect_back_or_to root_path, notice: "No results for your input"
        end
      end
    end

  end

  private

  def cuisine
    @cuisines = []
    @categories = Category.all
    @categories.each do |category|
      @cuisines << category.cuisine.downcase
    end
    @cuisines = @cuisines.uniq
    return @cuisines
  end

  def food_type
    @food_types = []
    @categories = Category.all
    @categories.each do |category|
      if category.food_type.present?
        @food_types << category.food_type.downcase
      end
    end
    @food_types = @food_types.uniq

    return @food_types
  end

  def name
    @names = []
    @categories = Category.all
    @categories.each do |category|
      @names << category.name.downcase
    end
    @names = @names.uniq
    return @names

  end

  def restaurant
    @restaurants_name = []
    @restaurants = Restaurant.all
    @restaurants.each do |restaurant|
      @restaurants_name << restaurant.name.downcase
    end
    return @restaurants_name
  end
end
