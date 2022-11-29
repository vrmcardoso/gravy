class RestaurantsController < ApplicationController

  def index
    @restaurant = Restaurant.find(params[:id])
  end

end
