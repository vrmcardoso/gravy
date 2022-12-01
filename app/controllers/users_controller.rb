class UsersController < ApplicationController

  def show
    @user = current_user
    @ranks = Rank.where("user_id = ?", @user.id)
    @dishes = []
    @ranks.each do |rank|
      @dishes << Dish.find(rank.dish_id)
    end
    @restaurants = []
    @dishes.each do |dish|
      @restaurants << Restaurant.find(dish.restaurant_id)
    end
    
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :photo)
  end
end
