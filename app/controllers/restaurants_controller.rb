class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new # Needed to instantiate the form_with
  end

  def create
    # raise
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save # Will raise ActiveModel::ForbiddenAttributesError
    if @restaurant.save
      redirect_to restaurants_path(@restaurant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :category)
  end
end
