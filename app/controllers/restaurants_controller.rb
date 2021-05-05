class RestaurantsController < ApplicationController
     before_action :redirect_if_not_logged_in?

    def new
        @restaurant = Restaurant.new
        @restaurant.build_city
    end 

    def create
        @restaurant = current_user.restaurants.new(restaurant_params)
        @restaurant = current_user.restaurants.build(restaurant_params)
        if @restaurant.save!
            flash[:notice] = "restaurant saved!"
            redirect_to restaurant_path(@restaurant)
        else
            render :new
        end   
    end 

    def index
    end 

    def show
        @restaurant = Restaurant.find(params[:id])
    end

    def edit
    end

    def destroy;id
        @restaurant = Restaurant.find_by(params[:id]).destroy
        if @restuarant.destroy!
            flash[:notice] = "Okay, its gone!"
            redirect_to root_path
        else
            render :show
    end 
end

private

    def restaurant_params
        params.require(:restaurant).permit(:name, 
        :hours, 
        :long_or_short_layover, 
        :price_point, 
        :discount,
        :additional_info,
        :city_ids,
        :user_id,
        city_attributes: [:name])
    end
end