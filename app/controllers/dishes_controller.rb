class DishesController < ApplicationController

  def index

    @dishes = Dish.all
    @restaurants = Restaurant.all
    
    if params[:query].present?
      @dishes = Dish.global_search(params[:query])
      @restaurants = Restaurant.global_search(params[:query])
    else
      @dishes = Dish.all
      @restaurants = Restaurant.all
    end
  end

  def show
    @dish = Dish.find(params[:id])

    @markers = 
      [{
        lat: @dish.restaurant.latitude,
        lng: @dish.restaurant.longitude
      }]
  end

end
