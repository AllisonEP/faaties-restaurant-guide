class RestaurantsController < ApplicationController
    
    before_action :redirect_if_not_logged_in?
    def new
        @restuarant = Restaurant.new
    end 

    def create
        @restaurant = current_user.restaurants.new(restaurant_params)
        @restaurant = current_user.cities.build(restaurant_params)
        if @restaurant.save!
            flash[:notice] = "Restaurant saved!"
            redirect_to restaurants_path
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
    end 
end

private

def restaurant_params
    params.require(:restaurant).permit(:name, :hours, :long_or_short_layover, :price_point, :discount, :additional_info)
end
end