class RanksController < ApplicationController

  def show
    @dishes = Dish.all
    @categories = Category.all
    @ranks = Rank.all

    # get the current user ranks (i.e ranking >0 and id= current id)
    @user_ranks = @ranks.select { |rank| rank.user_id == current_user.id }


    @relevant_categories = []
    @all_dishes = []

    @user_ranks.each do |user_rank|
      @dish_id = user_rank.dish_id
      @dish = @dishes.find { |dish| dish.id == @dish_id }
      @all_dishes << @dish
      @category_id = @dish.category_id
      @user_categories = @categories.find { |category| category.id == @category_id }
      @relevant_categories << @user_categories.name
    end

    @user_ranked_dishes = @all_dishes.filter { |dish| @relevant_categories.include? dish.category.name }

  end
end
