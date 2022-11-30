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

      # @dishes = Dish.global_search(params[:query])
      # @restaurants = Restaurant.global_search(params[:query])
    else
      # @dishes = Dish.all
      # @restaurants = Restaurant.all
    end
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

    @markers =
      [{
        lat: @dish.restaurant.latitude,
        lng: @dish.restaurant.longitude,
        image_url: helpers.asset_url("IconGrande.png")
      }]
  end

  # def cuisine
  #   @dishes = = Dish.global_search(params[:query])
  # end

end
