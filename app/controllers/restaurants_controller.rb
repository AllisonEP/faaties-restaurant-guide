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
        @restaurant = Restaurant.all
    end 

    def show
        @restaurant = Restaurant.find(params[:id])
    end

    def edit
        @restaurant = Restaurant.find_by_id(params[:id])
    end

    def update
        @restaurant = Restaurant.find_by_id(params[:id])
        @restaurant.update(restaurant_params)
        if @restaurant.save
            redirect_to restaurant_path      
        else
           render :edit 
        end
     end

    def destroy
        @restaurant = Restaurant.find_by(params[:id]).destroy
        if @restaurant.destroy!
            flash[:notice] = "Okay, its gone!"
            redirect_to restaurants_path
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