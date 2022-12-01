class CategoriesController < ApplicationController


  def top
    @dishes = Dish.all
    @restaurants = Restaurant.all
    @results = []
    if params[:query].present?
      result = params[:query].capitalize
      dishes = Dish.all
      cuisine
      food_type
      name
      if @cuisines.include? "#{result}"
        cuisine_dishes = dishes.select { |dish| dish.category.cuisine == result }
        @results = cuisine_dishes.sort_by { |dish| dish.sum_points}.reverse
      elsif @food_types.include? "#{result}"
        food_type_dishes = dishes.select { |dish| dish.category.food_type == result }
        @results = food_type_dishes.sort_by { |dish| dish.sum_points}.reverse
      elsif @names.include? "#{result}"
        name_dishes = dishes.select { |dish| dish.category.name == result }
        @results = name_dishes.sort_by { |dish| dish.sum_points}.reverse
      else
        "Wrong input"
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
end
