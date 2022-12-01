class RanksController < ApplicationController

  def show
    @dishes = Dish.all
    @ranks = Rank.all
    @user_ranks = @ranks.select { |rank| rank.user_id == current_user && rank.ranking.positive? }
    
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
