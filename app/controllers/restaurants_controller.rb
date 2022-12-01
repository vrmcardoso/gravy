class RestaurantsController < ApplicationController

  def index
    @restaurant = Restaurant.find(params[:id])
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @markers =
      [{
        lat: @restaurant.latitude,
        lng: @restaurant.longitude,
        image_url: helpers.asset_url("IconGrande.png")
      }]
  end

end
